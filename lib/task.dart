class Task {
  String _userId;
  String _taskId;
  String _title;
  String _desc;
  String _status;

  Task(this._userId, this._taskId, this._title, this._desc, this._status);

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get taskId => _taskId;

  set taskId(String value) {
    _taskId = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }
}

List<Task> generateDummyTasks() => List.generate(
    20,
    (i) => Task(
        '1', i.toString(), 'Task title #$i', 'Task detail #$i', 'Incomplete'));
