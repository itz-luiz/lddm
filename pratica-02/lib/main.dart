import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meus hábitos',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
        ),
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

                // IA <gemini> . <Usei para fazer esse botão para carregar a página de detalhes>
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaDetalhes(h: h)),
                  );
                },
              ),
          ],
        );
      },
    ),
  );
}

// IA <gemini> . <Usei para me ajudar a estilizar a tela, padding, colors, border, etc.>

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key, required this.h});
  final Habito h;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cores.surface,
      appBar: AppBar(
        title: Text(h.titulo),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 88.0,
                    top: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: cores.primary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cores.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        h.titulo,
                        style: TextStyle(
                          color: cores.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        h.meta,
                        style: TextStyle(
                          color: cores.onPrimary.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 14,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: cores.surface,
                    child: Icon(h.icone, size: 32, color: cores.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                construirCard(context, '7', 'streak'),
                const SizedBox(width: 8),
                construirCard(context, '5 / 8', 'hoje'),
                const SizedBox(width: 8),
                construirCard(context, '10', 'meta de dias'),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cores.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cores.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sobre este hábito",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cores.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Acompanhe e registre suas metas diariamente para manter a sua streak!",
                    style: TextStyle(
                      fontSize: 14,
                      color: cores.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget construirCard(BuildContext context, String valor, String legenda) {
  final cores = Theme.of(context).colorScheme;

  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: cores.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cores.outlineVariant),
      ),
      child: Column(
        children: [
          Text(
            valor,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: cores.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            legenda,
            style: TextStyle(
              fontSize: 12,
              color: cores.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  );
}

class Habito {
  final String titulo;
  final String meta;
  final IconData icone;

  const Habito({required this.titulo, required this.meta, required this.icone});
}

Future<List<Habito>> mostrarHabitos() async {
  // await Future.delayed(const Duration(seconds: 1));

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
    Habito(titulo: 'Dormir', meta: 'Meta: 7-8h por dia', icone: Icons.bed),
    Habito(titulo: 'Estudar', meta: 'Meta: 4h por dia', icone: Icons.code),
  ];
}
