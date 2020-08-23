import 'package:flutter_todo/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static DatabaseHelper _instance;
  Database _database;

  factory DatabaseHelper(){
    if(_instance==null)
      _instance=DatabaseHelper._internal();

    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> _initializeDB() async {

    if(_database!=null)
      return _database;

    final database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY,user_id INTEGER, title TEXT, desc TEXT,status TEXT)",
        );
      },
      version: 1,
    );

    return database;
  }

  Future<int> addTask(Map taskInfo) async {
    _database=await _initializeDB();
    return _database.insert('tasks', taskInfo);
  }

  Future<List<Task>> getTasks() async{
    _database=await _initializeDB();

    List<Map> taskMaps=await _database.query('tasks',orderBy: 'id desc');

    List<Task> tasks=List.generate(taskMaps.length, (index) {
      return Task(
        taskMaps[index]['userId'].toString(),
        taskMaps[index]['id'].toString(),
        taskMaps[index]['title'],
        taskMaps[index]['desc'],
        taskMaps[index]['status']
      );
    });

    return tasks;
  }

  Future<Task> getTask(int taskId) async{

    _database=await _initializeDB();

    List<Map> taskMap=await _database.query('tasks',where: 'id=?',whereArgs: [taskId]);

    return Task(
        taskMap.first['userId'].toString(),
        taskMap.first['id'].toString(),
        taskMap.first['title'],
        taskMap.first['desc'],
        taskMap.first['status']
    );
  }

  Future<int> deleteTask(int taskId) async{

    _database=await _initializeDB();
    return await _database.delete('tasks',where: 'id=?',whereArgs: [taskId]);
  }

  Future<int> updateTask(int taskId, Map taskInfo) async{
    _database=await _initializeDB();
    return await _database.update('tasks', taskInfo,where: 'id=?',whereArgs: [taskId]);
  }
}
