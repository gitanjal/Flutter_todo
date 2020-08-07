import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/Task.dart';
import 'package:flutter_todo/add_task.dart';
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

class ListScreenWidget extends StatelessWidget {
  final List<Task> taskList = getDummyTaskList();

  @override
  Widget build(BuildContext context) {

    _getTasksFromDB().then((taskList){
      taskList.forEach((task){
        print('----${task.title}');
      });
    });

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
          child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    print("${taskList[index].title}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskDetailStateful()),
                    );
                  },
                  title: Text("${taskList[index].title}"),
                  subtitle: Text("${taskList[index].status}"),
                );
              })),
    );
  }

  Future<List<Task>> _getTasksFromDB() async {
    final database =await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
    );

    final List<Map<String, dynamic>> taskMaps = await database.query('tasks');

    return List.generate(taskMaps.length, (index) {
      return Task(
        taskMaps[index]['user_id'].toString(),
        taskMaps[index]['id'].toString(),
        taskMaps[index]['title'],
        taskMaps[index]['desc'],
        taskMaps[index]['status'],
      );
    });
  }
}
