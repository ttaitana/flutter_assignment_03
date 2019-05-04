import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class Storage {
  int id;
  String title;
  bool done;

  Storage();

  Storage.formMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.title = map[columnTitle];
    this.done = map[columnDone] == 1;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class StorageProvider {
  Database db;

  Future open(String path) async {
    print('Oppening');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableTodo(
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDone integer not null
        )
      ''');
    });
  }

  Future<Storage> insert(Storage data) async {
    data.id = await db.insert(tableTodo, data.toMap());
    return data;
  }

  Future<Storage> getData(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return new Storage.formMap(maps.first);
    }
    return null;
  }

  Future<int> update(Storage data) async {
    return await db.update(tableTodo, data.toMap(),
        where: '$columnId = ?', whereArgs: [data.id]);
  }

  Future<List<Storage>> getTask() async{
    List<Map<String, dynamic>> data = await db.query(
      tableTodo,
      where: '$columnDone = 0'
    );
    return data.map((f) => Storage.formMap(f)).toList();
  }

  Future<List<Storage>> getComplete() async{
    List<Map<String, dynamic>> data = await db.query(
      tableTodo,
      where: '$columnDone = 1'
    );
    return data.map((f) => Storage.formMap(f)).toList();
  }

  Future delComplete() async{
    await this.db.delete(
      tableTodo,
      where: '$columnDone = 1',
    );
  }

  Future close() async => db.close();
}
