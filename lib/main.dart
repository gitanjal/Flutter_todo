import 'package:flutter/material.dart';
import 'package:flutter_todo/task.dart';
import 'package:flutter_todo/task_detail.dart';

import 'add_task.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ListScreenWidget());
  }
}

class ListScreenWidget extends StatelessWidget {
  final List<Task> taskList = getDummyTaskList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(),
      body: Container(
          child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    print("${taskList[index].title}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskDetail()),
                    );
                  },
                  title: Text("${taskList[index].title}"),
                  subtitle: Text("${taskList[index].status}"),
                );
              })),
    );
  }
}
