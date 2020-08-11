import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Task.dart';

class DatabaseHelper {
  static DatabaseHelper _instance = new DatabaseHelper._internal();
  Database _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {

    if(_database!=null)
      return _database;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY,user_id INTEGER, title TEXT, desc TEXT,status TEXT)",
        );
      },
      version: 1,
    );

    return _database;

  }

  Future<int> addTask(Map task) async {
    _database=await database;
    int row = await _database.insert('tasks', task);
    return row;
  }

  Future<List<Task>> getTasksFromDB() async {

    _database = await database;

    final List<Map<String, dynamic>> taskMaps = await _database.query('tasks');

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
