import 'package:flutter/material.dart';

class TaskDetailStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetailStateful>{

  String _status;
  String _markDoneBtnText;

  @override
  void initState() {

    _status="Incomplete";

    if(_status=="Incomplete")
      _markDoneBtnText="Mark as complete";
    else
      _markDoneBtnText="Mark as incomplete";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text("Task Title"),
          Text(_status),
          Text("Task Description"),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                    if(_status=='Incomplete')
                      markAsComplete();
                    else
                      markAsIncomplete();
                },
                child: Text(_markDoneBtnText),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Delete task"),
              )
            ],
          )
        ],
      ),
    );
  }

  void markAsComplete() {
    setState(() {
      _status='Complete';
      _markDoneBtnText="Mark as incomplete";
    });
  }

  void markAsIncomplete() {
    setState(() {
      _status='Incomplete';
      _markDoneBtnText="Mark as complete";
    });
  }
}

