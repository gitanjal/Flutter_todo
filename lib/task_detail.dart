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

  bool _deleted = false;
  bool _loading= true;

  Future<Task> _task;

  @override
  void initState() {
    super.initState();

    _task = _getATaskFromDB(int.parse(widget._taskId));
    _task.then((task){
      _loading=false;

      setState(() {
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:(_loading)?CircularProgressIndicator()
          : (_deleted)
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
                    Text(snapshot.data.status),
                    Text(snapshot.data.desc),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            if (snapshot.data.status == 'Incomplete')
                              markAsComplete();
                            else
                              markAsIncomplete();
                          },
                          child: Text((snapshot.data.status == 'Incomplete')?'Mark complete':'Mark incomplete'),
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

  Future<void> markAsComplete() async {

    setState(() {
      _loading=true;
    });

    Task task=await _task;

    Map<String, dynamic> map = {
      'title': task.title,
      'desc': task.desc,
      'user_id': 1,
      'status': 'Complete'
    };

    int row_id=await DatabaseHelper().update(map,int.parse(task.taskId));

    print('updated row---$row_id');
    if(row_id>=0) {
      setState(() {
        _task=_getATaskFromDB(int.parse(task.taskId));
        _loading=false;
      });
    }
  }

  void markAsIncomplete() async{

    setState(() {
      _loading=true;
    });

    Task task=await _task;

    Map<String, dynamic> map = {
      'title': task.title,
      'desc': task.desc,
      'user_id': 1,
      'status': 'Incomplete'
    };

    int rowsAffected=await DatabaseHelper().update(map,int.parse(task.taskId));

    if(rowsAffected==1) {
      setState(() {
        _task = _getATaskFromDB(int.parse(task.taskId));
        _loading = false;
      });
    }
  }

  Future<void> _deleteTask() async {
    setState(() {
      _loading = true;
    });

    Task task=await _task;
    int rowsAffected=await DatabaseHelper().delete(int.parse(task.taskId));

    if(rowsAffected==1) {
      setState(() {
        _deleted = true;
        _loading = false;
      });
    }
  }

  Future<Task> _getATaskFromDB(int taskId) async {
    return DatabaseHelper().getATasksFromDB(taskId);
  }
}
