import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final _formKey=GlobalKey<FormState>();

  final _controllerTitle=TextEditingController();
  final _controllerDesc=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _controllerTitle,
              decoration: InputDecoration(hintText: 'Enter the title'),
              validator: (value){
                if(value.isEmpty)
                  return 'Please enter a title';

                return null;
              },
            ),
            TextFormField(
              controller: _controllerDesc,
              decoration: InputDecoration(hintText: 'Enter the description'),
            ),
            RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate())
                  print('The title entered is : ${_controllerTitle.text}');
              },
              child: Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }
}
