import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

                  Map<String,dynamic> task={
                    'title':controllerTitle.text,
                    'desc':controllerDesc.text,
                    'user_id':1,
                    'status':'Incomplete',
                  };

                  _addToDB(task);
                }
              },
              child: Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }

  _addToDB(Map task) async{
    final database=await openDatabase(
      join(await getDatabasesPath(),'todo_database.db'),
      onCreate: (db,version){
        return db.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY,user_id INTEGER,title TEXT,desc TEXT,status TEXT)");
      },
      version: 1,
    );

    int row=await database.insert('tasks',task);
    print('Id of the inserted row $row');
  }

  _addToDBB(Map task) {

    getDatabasesPath().then((path){
      final database= openDatabase(
        join(path,'todo_database.db'),
        onCreate: (db,version){
          return db.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY,user_id INTEGER,title TEXT,desc TEXT,status TEXT)");
        },
        version: 1,
      );
      database.then((database){
         database.insert('tasks',task).then((row){
           print('Id of the inserted row --- $row');
         });

      });
    });



  }

}
