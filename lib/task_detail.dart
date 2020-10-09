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
  bool _loading=false;
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
        body: (_loading)?
              Center(child: CircularProgressIndicator())
            :(_deleted)
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
                                      onPressed: () {
                                        if(snapshot.data.status=='Incomplete')
                                          {
                                            Map<String,dynamic> newInfo={
                                              'title':snapshot.data.title,
                                              'desc':snapshot.data.desc,
                                              'user_id':snapshot.data.userId,
                                              'status':'Complete'
                                            };

                                            _updateStatus(newInfo, int.parse(snapshot.data.taskId));
                                          }
                                        else
                                          {
                                            Map<String,dynamic> newInfo={
                                              'title':snapshot.data.title,
                                              'desc':snapshot.data.desc,
                                              'user_id':snapshot.data.userId,
                                              'status':'Incomplete'
                                            };
                                            _updateStatus(newInfo, int.parse(snapshot.data.taskId));
                                          }


                                      },
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
                                                      _deleteTask(int.parse(snapshot.data.taskId));
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

  void _deleteTask(int taskId) async{

    setState(() {
      _loading=true;
    });

    print('Inside _deleteTask');

    int rowsAffected=await DatabaseHelper().deleteTask(taskId);

    if(rowsAffected==1) {
      setState(() {
        _deleted = true;
      });
    }

    setState(() {
    //  _loading=false;
    });


    Navigator.of(context).pop();
  }


  _updateStatus(Map updatedInfo,int taskId)
  async{

    setState(() {
      _loading=true;
    });


    int rowsAffected=await DatabaseHelper().updateTask(taskId, updatedInfo);



    setState(() {
      task=DatabaseHelper().getTask(widget.taskId);
      _loading=false;
    });


  }

}
