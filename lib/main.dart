import 'package:flutter/material.dart';
import 'package:flutter_todo/task.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListScreenWidget(),
    );
  }
}

class ListScreenWidget extends StatelessWidget {
   final List<Task> _taskList=generateDummyTasks();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: _taskList.length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              onTap: (){
                print('Clicked Task ${_taskList[index].title}');
              },
              title: Text(_taskList[index].title),
              subtitle: Text(_taskList[index].status),
            );
          }),
    );
  }
}