import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlflite/models/cart.dart';

class SqfliteDatabase{

  String tableName = "cart";

  Database? database;

  Future<void> init() async{

    String databasePath = await getDatabasesPath();


    await openDatabase(
        databasePath+"/"+"cart_db",
      version: 1,
      onCreate: (db,version) async{
          String sqlQuery = "CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT, price INTEGER)";
          await db.execute(sqlQuery);
          database = db;
      },
      onOpen: (db){
          database = db;
      },

      onUpgrade: (db,oldeVersion,newVersion){
          database = db;
      }
    );

  }

  Future<void> addCart(Cart cart) async{
   int? isInserted =  await database?.insert(tableName, cart.toJson());
   print(isInserted);
  }

  Future<List<Cart>> fetcAllCarts() async{
    List<Map<String, Object?>>? mapList = await database?.query(tableName);
    List<Cart> cartList = [];

    for(Map<String, Object?> item in mapList!){
      cartList.add(Cart.fromJson(item));
    }
    return cartList;
  }

  Future<void> delete(int id) async {
    await database?.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(Cart cart) async {
    await database?.update(tableName, cart.toJson(),
        where: 'id = ?', whereArgs: [cart.id]);
  }


}