import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final _formKey=GlobalKey<FormState>();

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
              validator: (value){
                if(value.isEmpty)
                  {
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
                if(_formKey.currentState.validate()) {
                  print('Task title is ${controllerTitle.text}');
                }
              },
              child: Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }
}
