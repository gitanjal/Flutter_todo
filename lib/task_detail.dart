import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text('Task title'),
          Text('Task status'),
          Text('Task description'),
          Row(children: <Widget>[
            RaisedButton(
              onPressed: (){},
              child: Text('Mark as complete'),
            ),
            RaisedButton(
              onPressed: (){},
              child: Text('Delete'),
            )
          ],)
        ],
      ),
    );
  }

}