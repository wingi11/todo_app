import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/Todo.dart';

class TodoRepository {

  Database database;

  TodoRepository() {
    init();
  }

  void init() async {
    database = await openDatabase(
        join(await getDatabasesPath(), "todo.db"),
        onCreate: (db, version) {
          return db.execute("CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, done INTEGER)");
        },
        version: 1
    );
  }

  Future<void> insertTodo(Todo todo) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}