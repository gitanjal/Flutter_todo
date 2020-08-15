import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/Task.dart';
import 'package:flutter_todo/add_task.dart';
import 'package:flutter_todo/database_helper.dart';
import 'package:flutter_todo/task_detail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ListScreenWidget());
  }
}

class ListScreenWidget extends StatefulWidget {
  @override
  _ListScreenWidgetState createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget> {
  Future<List<Task>> _taskList;

  @override
  void initState() {
    super.initState();
    _taskList = _getTasksFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          ).then((value) {
            setState(() {
              _taskList = _getTasksFromDB();
            });
          });
        },
      ),
      appBar: AppBar(
        title: Text('WhatTodo'),
      ),
      body: Container(
          child: FutureBuilder(
        future: _taskList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.length == 0) {
              return Center(
                child: Text('No data'),
              );
            } else
              return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print("${snapshot.data[index].title}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskDetailStateful(
                                  snapshot.data[index].taskId)),
                        ).then((value) {
                          setState(() {
                            _taskList = _getTasksFromDB();
                          });
                        });
                      },
                      title: Text("${snapshot.data[index].title}"),
                      subtitle: Text(
                        "${snapshot.data[index].status}",
                        style: TextStyle(
                            color:
                                (snapshot.data[index].status == 'Complete')
                                    ? Colors.greenAccent
                                    : Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                        ),
                      ),
                    );
                  });
          }
        },
      )),
    );
  }

  Future<List<Task>> _getTasksFromDB() async {
    return DatabaseHelper().getTasksFromDB();
  }
}
