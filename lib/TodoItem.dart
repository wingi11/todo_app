import 'package:flutter/cupertino.dart';

class TodoItem extends StatefulWidget {

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _switch = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        CupertinoSwitch(
          value: _switch,
          onChanged: (bool value) {
            setState(() { _switch = value; });
          },
        ),
        Flexible(
          flex: 2,
          child: CupertinoTextField(),
        )
      ],
    );
  }
}