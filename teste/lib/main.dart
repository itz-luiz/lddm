import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Future<List<Habito>> mostrarHabitos() async {
  // await Future.delayed(const Duration(seconds: 1)); // Reduzido para testes mais rápidos

  return const [
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
      icone: Icons.bed,
    ),
    Habito(
      titulo: 'Estudar',
      meta: 'Meta: 4h por dia',
      icone: Icons.code,
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
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF194A6E), // Tom azul escuro da referência
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
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navega para a tela de detalhes enviando o hábito clicado
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDetalhesHabito(habito: h),
                    ),
                  );
                },
              ),
          ],
        );
      },
    ),
  );
}

// Classe do modelo de dados
class Habito {
  final String titulo;
  final String meta;
  final IconData icone;

  const Habito({
    required this.titulo,
    required this.meta,
    required this.icone,
  });
}

// Nova tela de detalhes com o cabeçalho dinâmico
class TelaDetalhesHabito extends StatelessWidget {
  final Habito habito;

  const TelaDetalhesHabito({super.key, required this.habito});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        // O título da AppBar recebe diretamente o título do objeto enviado
        title: Text(
          habito.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card Principal Superior
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF2E82BA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      habito.icone,
                      size: 28,
                      color: const Color(0xFF2E82BA),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habito.titulo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          habito.meta,
                          style: const TextStyle(
                            color: Colors.white70,
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

            // Métricas (Linha com 3 cards)
            Row(
              children: [
                _buildCardEstatistica('12', 'dias seguidos'),
                const SizedBox(width: 8),
                _buildCardEstatistica('5 / 8', 'hoje'),
                const SizedBox(width: 8),
                _buildCardEstatistica('62%', 'no mês'),
              ],
            ),
            const SizedBox(height: 16),

            // Card "Sobre este hábito"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sobre este hábito',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF194A6E),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Acompanhe e registre suas metas diariamente para manter a consistência e alcançar seus objetivos.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5568),
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

  // Widget auxiliar para os cards numéricos
  static Widget _buildCardEstatistica(String valor, String legenda) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            Text(
              valor,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF194A6E),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              legenda,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
              ),
            ),
          ],
        ),
      ),
    );
  }
}