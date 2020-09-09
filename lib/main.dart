import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/database_helper.dart';
import 'package:flutter_todo/task.dart';
import 'package:flutter_todo/add_task.dart';
import 'package:flutter_todo/task_detail.dart';

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

  Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks=DatabaseHelper().getTasks();
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
          ).then((value){
            setState(() {
              _tasks=DatabaseHelper().getTasks();
            });
          });
        },
      ),
      appBar: AppBar(),
      body: Container(
          child: FutureBuilder(
            future: _tasks,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.data==null)
                {
                  return Center(child: CircularProgressIndicator());
                }
              else
                {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            print("${snapshot.data[index].title}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskDetail(int.parse(snapshot.data[index].taskId))),
                            );
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
}
