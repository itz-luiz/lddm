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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: Text(
          h.titulo,
          // style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(h.icone, size: 32, color: Colors.deepPurple),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          h.titulo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          h.meta,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                construirCard('7', 'streak'),
                const SizedBox(width: 8),
                construirCard('5 / 8', 'hoje'),
                const SizedBox(width: 8),
                construirCard('10', 'meta de dias'),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Sobre este hábito",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 12),

                  Text(
                    "Acompanhe e registre suas metas diariamente para manter a sua streak!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
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

// /*
Widget construirCard(String valor, String legenda) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Text(
            valor,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            legenda,
            style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
        ],
      ),
    ),
  );
}

// */
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
