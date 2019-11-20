import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TextField.dart' as prefix0;
import 'package:todo_app/TodoItem.dart';
import 'package:todo_app/repository/TodoRepository.dart';
import 'package:vibrate/vibrate.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



void main() async {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  TodoRepository repo = TodoRepository();


  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("ToDo"),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              itemExtent: 40,
              children: <Widget>[
                TodoItem(),
                TodoItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}