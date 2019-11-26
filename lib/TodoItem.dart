import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/Todo.dart';

class TodoItem extends StatefulWidget {
  Todo todo;
  TodoItemController itemController;

  TodoItem(Todo todo, TodoItemController itemController) {
    this.todo = todo;
    this.itemController = itemController;
  }

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    textEditingController = TextEditingController(text: widget.todo.title);

    // TODO: implement build
    return Row(
      children: <Widget>[
        CupertinoSwitch(
          value: widget.todo.done,
          onChanged: (bool value) {
            setState(() {
              widget.todo.done = value;
            });
            widget.itemController.updateItem(widget.todo);
          },
        ),
        Flexible(
          flex: 2,
          child: CupertinoTextField(
            controller: textEditingController,
            decoration: BoxDecoration(border: null),
            style: TextStyle(fontSize: 20),
            onEditingComplete: () {
              if (textEditingController.text.isEmpty) {
                widget.itemController.removeItem(widget.todo);
              } else {
                widget.todo.title = textEditingController.text;
                widget.itemController.updateItem(widget.todo);
              }
            },
          ),
        ),
      ],
    );
  }
}
