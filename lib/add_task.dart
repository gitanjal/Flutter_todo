import 'package:flutter/material.dart';
import 'package:flutter_todo/Task.dart';
import 'package:flutter_todo/database_helper.dart';
import 'package:flutter_todo/task_detail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  final controllerTitle = TextEditingController();
  final controllerDesc = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controllerTitle,
              decoration: InputDecoration(hintText: 'Task title'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controllerDesc,
              minLines: 10,
              maxLines: 10,
              decoration: InputDecoration(hintText: 'Task description'),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print('Task title is ${controllerTitle.text}');

                  Map<String, dynamic> map = {
                    'title': controllerTitle.text,
                    'desc': controllerDesc.text,
                    'user_id': 1,
                    'status': 'Incomplete'
                  };
                  _addToDB(context,map);
                }
              },
              child: Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }

  _addToDB(BuildContext context,Map task) async {
    int row =await DatabaseHelper().addTask(task);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailStateful(row.toString())),
    );
  }
}
