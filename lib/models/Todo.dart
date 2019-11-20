import 'package:sqflite/sqflite.dart';

class Todo {
  final int id;
  final bool done;
  final String title;

  Todo({this.id, this.done, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }
}

