import 'package:flutter/material.dart';

class TaskDetailStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetailStateful>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text("Task Title"),
          Text("Incomplete"),
          Text("Task Description"),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text("Mark as done"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Delete task"),
              )
            ],
          )
        ],
      ),
    );
  }
}



/*class TaskDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text("Task Title"),
          Text("Incomplete"),
          Text("Task Description"),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text("Mark as done"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Delete task"),
              )
            ],
          )
        ],
      ),
    );
  }
}*/
