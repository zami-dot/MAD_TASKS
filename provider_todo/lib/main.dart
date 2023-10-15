import 'package:flutter/material.dart';
import 'todo.dart';
import 'todonotifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) {
          return TodoNotifier();
        },
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  bool zone = false;
  final nTodoTitle = TextEditingController();
  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Todo'),
          content: TextField(
            controller: nTodoTitle,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Todo Title'),
            onSubmitted: (newTodoTitle) {
              if (newTodoTitle.isNotEmpty) {
                context.read<TodoNotifier>().addTodo(Todo(
                      isDone: false,
                      title: newTodoTitle,
                    ));
                zone = true;
                nTodoTitle.text = "";
                Navigator.of(context).pop(); // Close the dialog
              }
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (zone == true) {
                  context.read<TodoNotifier>().addTodo(Todo(
                        isDone: false,
                        title: nTodoTitle.text,
                      ));
                  zone = false;
                }

                Navigator.of(context).pop();
                nTodoTitle.text = ""; // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "TODO List",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: context.watch<TodoNotifier>().getTodos.length,
          itemBuilder: (context, index) {
            Todo todo = context.watch<TodoNotifier>().getTodos[index];
            return ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              tileColor: const Color.fromARGB(255, 209, 154, 219),
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (value) {
                  context.read<TodoNotifier>().toggleIsDone(index);
                },
              ),
              title: Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.amberAccent,
                ),
                onPressed: () {
                  context.read<TodoNotifier>().removeTodo(index);
                },
              ),
              subtitle: todo.isDone
                  ? const Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : const Text(
                      "Not Done",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
              onTap: () {
                context.read<TodoNotifier>().toggleIsDone(index);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
          onPressed: () {
            _showAddTodoDialog();
          }),
    );
  }
}
