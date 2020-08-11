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
    return MaterialApp(home: ListScreenWidget());
  }
}

class ListScreenWidget extends StatefulWidget {
  @override
  _ListScreenWidgetState createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget> {
  Future<List<Task>> taskList;

  @override
  void initState() {
    super.initState();
    taskList = _getTasksFromDB();
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
          );
        },
      ),
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
        future: taskList,
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
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print("${snapshot.data[index].title}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskDetailStateful()),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      title: Text("${snapshot.data[index].title}"),
                      subtitle: Text("${snapshot.data[index].status}"),
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
