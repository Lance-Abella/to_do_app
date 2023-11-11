// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unnecessary_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'todo_item.dart';
import 'todo_services.dart';

class TodoListPage extends StatefulWidget {
  final List<TodoItem> todos;

  TodoListPage(this.todos);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoService _todoService = TodoService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text(
      "To-do-List",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 79, 56, 49), 
            Color.fromARGB(255, 121, 94, 85), 
            Color.fromARGB(255, 140, 116, 108), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    elevation: 0,
  ),

  body: ValueListenableBuilder(
    valueListenable: Hive.box<TodoItem>('todoBox').listenable(),
    builder: (context, Box<TodoItem> box, _) {
      return ListView.builder(
        itemCount: box.values.length,
        itemBuilder: (context, index) {
          var todo = box.getAt(index);
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(todo!.title),
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (val) {
                  _todoService.toggleCompleted(index, todo);
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _todoService.deleteTodo(index);
                },
              ),
            ),
          );
        },
      );
    },
  ),

  floatingActionButton: FloatingActionButton(
    backgroundColor: Colors.brown,
    onPressed: () async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add To-do-list'),
            content: TextField(
              controller: _controller,
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(121, 85, 72, 1)),
                ),
                child: Text('Add'),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    var todo = TodoItem(_controller.text, false);
                    _todoService.addItem(todo);
                    _controller.clear();
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        },
      );
    },
    child: Icon(Icons.add),
  ),
);

  }
}