import 'package:google_maps_flutter/google_maps_flutter.dart';

class Order {
  late String _orderItems;
  late String _destStr;
  late String _destDesc;

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

  Order(this._orderItems, this._destStr,this._destDesc);
}
