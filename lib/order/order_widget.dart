import 'dart:convert';

import 'package:courier_prototype/home_widget.dart';
import 'package:courier_prototype/order/order.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderWidget extends StatefulWidget {
  final Order? order;
  final Function? showOnMap;
  const OrderWidget({Key? key, this.order, this.showOnMap}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  Color fontColor = Colors.black;
  late LatLng latLng; //Color.fromARGB(255, 255, 105, 0);

  // _getLocationName(LatLng latlng) async {
  //   final coordinates = new Coordinates(widget.order!.destLatLng.latitude,
  //       (widget.order!.destLatLng.longitude));
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   setState(() {
  //     locationName = addresses.first.addressLine;
  //   });
  // }

  getLocCoords() async {
    final query = widget.order!.destStr;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    setState(() {
      latLng = LatLng(first.coordinates.latitude, first.coordinates.longitude);
    });
  }

  @override
  void initState() {
    getLocCoords();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Products: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                      fontSize: 25))),
          RichText(
              text: TextSpan(
                  text: widget.order!.orderItems,
                  style: TextStyle(color: fontColor, fontSize: 20))),
          Text(' '),
          RichText(
              text: TextSpan(
                  text: 'Address: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                      fontSize: 25))),
          Container(
            child: RichText(
              text: TextSpan(
                  text: widget.order!.destStr,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      widget.showOnMap!(latLng);
                    }),
            ),
            // padding:  EdgeInsets.all(2),
            // decoration: BoxDecoration(
            //   color: Colors.blue[200],
            //   borderRadius: BorderRadius.all(Radius.circular(10)),
            // ),
          ),
          Text(' '),
          RichText(
              text: TextSpan(
                  text: 'Address additional info: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                      fontSize: 25))),
          RichText(
              text: TextSpan(
                  text: widget.order!.destDesc,
                  style: TextStyle(color: fontColor, fontSize: 20))),
          Text(' '),
        ],
      ),
    );
  }
}
