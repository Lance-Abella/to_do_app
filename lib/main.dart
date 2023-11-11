// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/todo_item.dart';

import 'home.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
 
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));

}

