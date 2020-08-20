import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetail> {
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
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirm delete'),
                          content: Text('Delete Task?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                _deleteTask();
                              },
                              child: Text('Delete'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      });
                },
                child: Text("Delete task"),
              )
            ],
          )
        ],
      ),
    );
  }

  void _deleteTask() {
    print('Inside _deleteTask');
    Navigator.of(context).pop();
  }
}
