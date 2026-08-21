import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
      Habito(titulo: 'Dormir', meta: 'Meta: 7-8h por dia', icone: Icons.bed),
      Habito(titulo: 'Estudar', meta: 'Meta: 4h por dia', icone: Icons.code),
    ];
  }

  late final Future<List<Habito>> _futuro;

  void initState() {
    super.initState();
    _futuro = mostrarHabitos();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [const Text()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Habito {
  final String titulo;
  final String meta;
  final IconData icone;

  const Habito({required this.titulo, required this.meta, required this.icone});
}
