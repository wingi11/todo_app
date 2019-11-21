import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TodoItem.dart';
import 'package:todo_app/models/Todo.dart';
import 'package:todo_app/repository/TodoRepository.dart';

void main() async {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TodoItemController itemController;
  TextEditingController textController;

  ///
  /// Initialise the TodoItem- and TextEditingController
  ///
  @override
  initState() {
    super.initState();
    itemController = TodoItemController(this);
    textController = TextEditingController();
  }

  ///
  /// Builds the widget
  ///
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
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          itemExtent: 45,
                          itemCount: itemController.todoList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              new TodoItem(itemController.todoList[index],
                                  itemController))),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: CupertinoTextField(
                          controller: textController,
                          style: TextStyle(fontSize: 20),
                          onEditingComplete: () {
                            print(textController.text);
                            itemController.addItem(textController.text);
                            textController.text = "";
                          },
                        ),
                      ),
                      CupertinoButton(
                        child: Text("Remove"),
                        onPressed: () {
                          itemController.removeAll();
                        },
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

///
/// Handles the todo items
///
class TodoItemController {
  TodoRepository repo = TodoRepository();
  _MainAppState _mainAppState;

  List<Todo> todoList = [];

  ///
  /// Constructor that gets every open item from the repository
  ///
  TodoItemController(_MainAppState _mainAppState) {
    this._mainAppState = _mainAppState;
    repo.init().then((_) {
      repo.getAllOpenTodos().then((todos) {
        _mainAppState.setState(() {
          todoList = todos;
          print(todos);
        });
      });
    });
  }

  ///
  /// Adds an item to the list and inserts it to the database
  ///
  void addItem(String text) {
    _mainAppState.setState(() {
      if (text.isNotEmpty) {
        Todo newTodo = Todo(id: null, done: false, title: text);
        todoList.add(newTodo);
        repo.insertTodo(newTodo);
      }
    });
  }

  ///
  /// Updates an item inside the database
  ///
  void updateItem(Todo item) {
    repo.updateTodo(item);
  }

  ///
  /// Removes an item inside the list and inside the database
  ///
  void removeItem(Todo item) {
    _mainAppState.setState(() {
      todoList.remove(item);
      repo.removeTodo(item);
    });
  }

  ///
  /// Removes every item from the list and from the database
  ///
  void removeAll() {
    _mainAppState.setState(() {
      todoList.clear();
      repo.removeAllTodos();
    });
  }
}
