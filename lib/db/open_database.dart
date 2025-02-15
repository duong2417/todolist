
import '../const/const.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
 
class OpenDATABASE{
 
  static Database? _db;//private mới gọi đc singleton
  Database get db=>_db!;
  OpenDATABASE._internal();
  static final OpenDATABASE instance=OpenDATABASE._internal();
init()async{
_db= await openDatabase(
join(await getDatabasesPath(),"$TABLE_NAME.db"),
onCreate: (db,version)=> db.execute(
  "CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY, content TEXT)"),
version:1
);
}
}