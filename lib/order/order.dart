import 'package:google_maps_flutter/google_maps_flutter.dart';

class Order {
  late String _orderItems;
  late LatLng _destLatLng;
  late String _destDesc;

  String get orderItems=> _orderItems;
  set orderItems(String val) {
    _orderItems = val;
  }

  LatLng get destLatLng=> _destLatLng;
  set destLatLng(LatLng val) {
    _destLatLng = val;
  }

  String get destDesc => _destDesc;
  set destDesc(String val) {
    _destDesc = val;
  }

  Order(this._orderItems, this._destLatLng,this._destDesc);
}
