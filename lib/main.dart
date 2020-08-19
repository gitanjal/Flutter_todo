import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body:ListScreenWidget()
      ),
    );
  }
}

class ListScreenWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello world"),
    );
  }
}


