import 'package:flutter/material.dart';
import 'package:flutter_todo/database_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final controllerTitle = TextEditingController();
  final controllerDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: controllerTitle,
                  decoration: InputDecoration(
                      hintText: 'Task title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.blue, width: 2))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),status
                SizedBox(height: 10,),
                TextFormField(
                  controller: controllerDesc,
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Task description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side:BorderSide(
                        color: Colors.grey,
                        width: 2,
                      )
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print('Task title is ${controllerTitle.text}');

                      Map<String, dynamic> map = {
                        'title': controllerTitle.text,
                        'desc': controllerDesc.text,
                        'user_id': 1,
                        'status': 'Incomplete'
                      };
                      _addToDB(map);
                    }
                  },
                  child: Text('Add Task'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addToDB(Map task) async {
    int row = await DatabaseHelper().addTask(task);
    print('Id of the inserted item: $row');

    if (row == -1) {
      //error occurred
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Failed to add the Task'),
      ));
    } else {
      //Task inserted into the DB
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Task added successfully'),
      ));

      _formKey.currentState.reset();
    }
  }
}
