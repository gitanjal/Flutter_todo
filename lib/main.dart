import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [DefaultMaterialLocalizations.delegate],
      builder: (context,int){
        return  CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Me Title'),
          ),
          child: SafeArea(
            child: Container(
              color: Colors.blue,
              child: Text("Hellow",textDirection: TextDirection.ltr,),
            ),
          ),
        );
      },
      color: Colors.blue,
    );
  }
}


