import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Future<List<Habito>> mostrarHabitos() async {
  await Future.delayed(const Duration(seconds: 5));

  return [
    Habito(
      titulo: 'Beber água',
      meta: 'Meta: 4L por dia',
      icone: Icons.local_drink,
    ),
    Habito(
      titulo: 'Academia',
      meta: 'Meta: 5x por semana',
      icone: Icons.fitness_center,
    ),
    Habito(
      titulo: 'Dormir',
      meta: 'Meta: 7-8h por dia',
      icone: Icons.bed
    ),
    Habito(
      titulo: 'Estudar',
      meta: 'Meta: 4h por dia',
      icone: Icons.code
    ),
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meus hábitos',
      theme: ThemeData(appBarTheme: 
        const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
        )
      ),
      home: TelaHabitos(futuro: mostrarHabitos()),
    );
  }
}

class TelaHabitos extends StatelessWidget {
  const TelaHabitos({super.key, required this.futuro});

  final Future<List<Habito>> futuro;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Meus hábitos')),
    body: FutureBuilder<List<Habito>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Não foi possível carregar os hábitos'),
          );
        }

        final habitos = snapshot.data!;
        if (habitos.isEmpty) {
          return const Center(child: Text('Nenhum hábito salvo na lista.'));
        }

        return ListView(
          children: [
            for (final h in habitos)
              ListTile(
                leading: Icon(h.icone),
                title: Text(h.titulo),
                subtitle: Text(h.meta),
              ),
          ],
        );
      },
    ),
  );
}

class Habito {
  final String titulo;
  final String meta;
  final IconData icone;

  const Habito({required this.titulo, required this.meta, required this.icone});
}
