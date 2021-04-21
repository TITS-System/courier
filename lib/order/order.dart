import 'package:google_maps_flutter/google_maps_flutter.dart';

class Order {
  late int _id; 
  late String _orderItems;
  late String _destStr;
  late String _destDesc;

  int get id=> _id;
  set id(int val) {
    _id = val;
  }

  String get orderItems=> _orderItems;
  set orderItems(String val) {
    _orderItems = val;
  }

  String get destStr=> _destStr;
  set destStr(String val) {
    _destStr = val;
  }

  String get destDesc => _destDesc;
  set destDesc(String val) {
    _destDesc = val;
  }

  Order(this._id, this._orderItems, this._destStr,this._destDesc);
}
