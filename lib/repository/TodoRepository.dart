import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/Todo.dart';

///
/// Handles the database connection and operations
///
class TodoRepository {
  Database database;

  ///
  /// Creates a database and connects to it
  ///
  Future<void> init() async {
    database = await openDatabase(join(await getDatabasesPath(), "todo.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, done INTEGER)");
    }, version: 1);
  }

  ///
  /// Inserts an item into the database
  ///
  Future<void> insertTodo(Todo todo) async {
    final Database db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///
  /// Removes an item from the database
  ///
  Future<void> removeTodo(Todo todo) async {
    final Database db = await database;
    await db.rawQuery("DELETE FROM todos WHERE id = ${todo.id}");
  }

  ///
  /// Removes every item from the todos table
  ///
  Future<void> removeAllTodos() async {
    final Database db = await database;
    await db.rawQuery("DELETE FROM todos");
  }

  ///
  /// Updates an item in the database
  ///
  Future<void> updateTodo(Todo todo) async {
    final Database db = await database;
    await db.rawQuery(
        "UPDATE todos SET title='${todo.title}', done=${todo.done ? 1 : 0} WHERE id = ${todo.id}");
  }

  ///
  /// Retrieves every item from the database
  ///
  Future<List<Todo>> getAllTodos() async {
    final Database db = await database;
    List<Map> todos = await db.rawQuery("SELECT * FROM todos");
    List<Todo> result = List();
    for (Map todo in todos) {
      result.add(Todo(
          id: todo["id"],
          done: todo["done"] == 1 ? true : false,
          title: todo["title"]));
    }
    return result;
  }

  ///
  /// Retrieves every item from the database which is not done yet
  ///
  Future<List<Todo>> getAllOpenTodos() async {
    final Database db = await database;
    List<Map> todos = await db.rawQuery("SELECT * FROM todos WHERE done = 0");
    List<Todo> result = List();
    for (Map todo in todos) {
      result.add(Todo(id: todo["id"], done: false, title: todo["title"]));
    }
    return result;
  }
}
