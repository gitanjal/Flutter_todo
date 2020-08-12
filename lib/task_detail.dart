import 'package:flutter/material.dart';
import 'package:flutter_todo/Task.dart';
import 'package:flutter_todo/database_helper.dart';

class TaskDetailStateful extends StatefulWidget {
  final String _taskId;

  TaskDetailStateful(this._taskId);

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetailStateful> {
  String _status;
  String _markDoneBtnText;

  bool _deleted = false;

  Future<Task> _task;

  @override
  void initState() {

    if (_status == "Incomplete")
      _markDoneBtnText = "Mark as complete";
    else
      _markDoneBtnText = "Mark as incomplete";

    _task = _getTasksFromDB(int.parse(widget._taskId));
    _task.then((task){
      _status=task.status;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (_deleted)
          ? Center(
              child: Text("Successfully deleted the task"),
            )
          : FutureBuilder(
              future: _task,
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(child: CircularProgressIndicator());
                return Column(
                  children: <Widget>[
                    Text(snapshot.data.title),
                    Text(_status),
                    Text(snapshot.data.desc),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            if (_status == 'Incomplete')
                              markAsComplete();
                            else
                              markAsIncomplete();
                          },
                          child: Text(_markDoneBtnText),
                        ),
                        RaisedButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete task'),
                                  content: Text('Confirm?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        _deleteTask();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text("Delete task"),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
    );
  }

  void markAsComplete() {

    

    setState(() {
      _status = 'Complete';
      _markDoneBtnText = "Mark as incomplete";
    });
  }

  void markAsIncomplete() {
    setState(() {
      _status = 'Incomplete';
      _markDoneBtnText = "Mark as complete";
    });
  }

  void _deleteTask() {
    setState(() {
      _deleted = true;
    });
  }

  Future<Task> _getTasksFromDB(int taskId) async {
    return DatabaseHelper().getATasksFromDB(taskId);
  }
}
