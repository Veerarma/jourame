import 'package:jourame/model/j_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider
{
 DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database  ;

  Future<Database> get database async{
    if(_database !=null){
      return _database;
    }
    _database =await initDB();
    return _database;
  }
  
  initDB() async{
    return await openDatabase(join(await getDatabasesPath(),"jdb.db"),
      onCreate: (db, version) async {

      await db.execute(''' 
      CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          date DATE
          )
      ''');
      },version: 1);
  }

  addNewNote(JModel note) async{
    final db = await database;
    db.insert("notes", note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getNotes(DateTime _dateTime) async{
    final db = await database;
    if(_dateTime == null) {

        DateTime now=DateTime.now();
      _dateTime=DateTime(now.year,now.month,now.day,now.hour-12);
      print(_dateTime);
    }
    DateTime d2 =_dateTime.add(const Duration(days: 1));
    // ignore: avoid_print
    print(d2);
    var res = await db.rawQuery("SELECT * FROM notes WHERE date BETWEEN '$_dateTime' AND '$d2'");
    if(res.isEmpty){
      return Null;
    }
    else{
      var resultMap=res.toList();
      //print(resultMap);
      return resultMap.isNotEmpty ? resultMap:Null;
    }
  }

 Future<int> deleteNote(int id) async{
    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id = '$id'");
    return count;
 }
}