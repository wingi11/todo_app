import 'package:flutter/cupertino.dart';

class TextField extends StatefulWidget {
  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  TextEditingController _textController;

 @override
 void initState() {
    super.initState();
    _textController = TextEditingController(text: "initial");
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(controller: _textController);
  }
}