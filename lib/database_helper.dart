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
    final database =await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
    );

    final List<Map<String, dynamic>> taskMaps = await database.query('tasks');

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

  Future<Task> getATaskFromDB(int taskId) async {

    _database=await database;

    List<Map> maps =
    await _database.query('tasks', where: 'id = ?', whereArgs: [taskId]);
    if (maps.length > 0) {
      return Task(
        maps.first['user_id'].toString(),
        maps.first['id'].toString(),
        maps.first['title'],
        maps.first['desc'],
        maps.first['status'],
      );
    }
    return null;
  }

}
