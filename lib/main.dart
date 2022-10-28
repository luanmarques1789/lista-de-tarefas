import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Método principal chama o MyApp()
void main() {
  runApp(const MyApp());
}

// Tela contém um MaterialApp como raiz
// A tela da aplicação é definida em MyHomePage("titulo")
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Lista de Tarefas'), // tela principal
    );
  }
}

// Classe que contém a tela principal
// A tela e o "estado" da tela são desenhados em _MyHomePageState
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Classe que contém a tela e mantém os valores das variáveis
class _MyHomePageState extends State<MyHomePage> {
  // controlar o texto da nova tarefa
  TextEditingController campoTexto = TextEditingController();

  // lista com todas as tarefas
  List<String> listaTarefas = [];

  // método que adiciona uma tarefa na lista
  void adicionarTarefa() {
    setState(() {
      if (campoTexto.text.trim().isNotEmpty) {
        listaTarefas.add(campoTexto.text);
        print("Adicionado tarefa ${listaTarefas.last}");
        print("Total de tarefas atualmente: ${listaTarefas.length}");
      }
    });
  }

  // método que exclui um elemento da lista
  void excluirItem(int i) {
    setState(() {
      listaTarefas.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Tarefa a fazer:",
                          border: OutlineInputBorder()),
                      controller: campoTexto,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: adicionarTarefa,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20) // arrumar altura do botão
                        ),
                    child: const Text("Adicionar"),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                // é igual uma Column, mas permite ser "rolado na tela"
                child: ListView(
                  children: [
                    for (int i = 0; i < listaTarefas.length; i++)
                      // cada ListTile é um Slidable que pode ser "empurrado"
                      Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                excluirItem(i);
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Excluir',
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(listaTarefas[i]),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Total de tarefas: ${listaTarefas.length}"),
            ],
          ),
        ),
      ),
    );
  }
}
