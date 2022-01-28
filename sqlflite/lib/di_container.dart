
import 'package:get_it/get_it.dart';
import 'package:sqlflite/database/sqflite_database.dart';
import 'package:sqlflite/providers/cart_provider.dart';

final sl = GetIt.instance;

Future<void> init() async{

  sl.registerFactory(() => CartProvider(database: sl()));

  //database
  SqfliteDatabase sqfliteDatabase = SqfliteDatabase();
  sqfliteDatabase.init();

  sl.registerLazySingleton(() => sqfliteDatabase);

}