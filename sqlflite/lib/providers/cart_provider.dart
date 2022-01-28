
import 'package:flutter/cupertino.dart';
import 'package:sqlflite/database/sqflite_database.dart';
import 'package:sqlflite/models/cart.dart';

class CartProvider extends ChangeNotifier{
  final SqfliteDatabase database;

  List<Cart> _cartList = [];

  List<Cart> get cartList => _cartList;

  CartProvider({required this.database}){
    getAllCarts();
  }

  Future<void> addCart(Cart cart) async{
    await database.addCart(cart);
    getAllCarts();
  }

  Future<void> delete(int id) async{
    await database.delete(id);
    getAllCarts();
  }

  Future<void> update(Cart cart) async{
    await database.update(cart);
    getAllCarts();
  }

  Future<void> getAllCarts() async{

    _cartList = await database.fetcAllCarts();
    notifyListeners();

  }






}