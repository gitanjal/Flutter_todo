import 'package:flutter/material.dart';
import 'package:flutter_todo/database_helper.dart';
import 'package:flutter_todo/task.dart';

class TaskDetail extends StatefulWidget {

  final int taskId;
  TaskDetail(this.taskId);

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetail> {
  bool _deleted = false;
  Future<Task> task;

  @override
  void initState() {
    super.initState();

    task=DatabaseHelper().getTask(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: (_deleted)
            ? Center(child: Text('Task deleted successfully'))
            : FutureBuilder(
                future: task,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.data==null)
                          return Center(child: CircularProgressIndicator());
                        else
                          {
                            return Column(
                              children: <Widget>[
                                Text(snapshot.data.title),
                                Text(snapshot.data.status),
                                Text(snapshot.data.desc),
                                Row(
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: () {},
                                      child: Text((snapshot.data.status=="Incomplete")?"Mark as Complete":"Mark as Incomplete"),
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
                            );
                          }
                    },
              ));
  }

  void _deleteTask() {
    print('Inside _deleteTask');

    setState(() {
      _deleted = true;
    });

    Navigator.of(context).pop();
  }
}
