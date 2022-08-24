 // ignore_for_file: avoid_print


import 'package:sqflite/sqflite.dart';

import '../../model/plantsModel.dart';

late Database database;

class DataBase {
  
  createDB() async {
    await openDatabase(
      "a3.db",
      version: 1,
      onCreate: (db, version) async {
        print("database is created");
        try {
          String t1 = "create table favProduct(id string ,i int);";
          await db.execute(t1);
        } catch (e) {
          print("erorr is " + e.toString());
        }
      },
      onOpen: (db) {},
    ).then((value) {
      database = value;
    });
  }

  Future<List<Map>> getFavProduct() async {
    String sql = "select * from favProduct";
    // return list of map of persons
    return await database.rawQuery(sql);
  }

  Future<int> insertFavProduct(Product z) async {
    return await database.insert("favProduct", {"id":z.id,"i":z.indx});
  }

  deletFavProduct(Product z) async {
    await database.transaction((txn) async {
      database
          .rawDelete(
              'DELETE FROM favProduct WHERE i = ${z.indx} and id=\'${z.id}\' ')
          .then((value) {
        print("peson ${z.id} in table favProduct deleted successfully");
      }).catchError((error) {
        print("deleting peson ${z.id} in table favProduct error: $error");
      });
    });
  }
  Future<void> updateProduct(Product z) async {
    print(z.indx);
    await database
        .rawUpdate('UPDATE favProduct set i = ${z.indx} WHERE  id=\'${z.id}\' ');
  }
}
 