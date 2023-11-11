// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/todo_services.dart';

import 'todo_item.dart';
import 'todo_listpage.dart';

class Home extends StatelessWidget {
 Home({super.key});

 final TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _todoService.getAllTodos(), 
        builder: (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return TodoListPage(snapshot.data ?? []);
            }
            else{
              return Center(
                child: CircularProgressIndicator()
                );
            }
          },
      ),
    );
  }
}