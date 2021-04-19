import 'package:courier_prototype/order/order.dart';
import 'package:courier_prototype/order/order_accepted_widget.dart';
import 'package:courier_prototype/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'marker_popup.dart';
import 'order/order_new_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String pageType = "curOrder";
  bool orderAccepted = false;
  late OrderWidget curOrder = OrderWidget(
    order: Order('pizza', LatLng(53.307931, 34.301674), 'кв.10'),
    showOnMap: _showLocOnMap,
  );
  LatLng _center = const LatLng(53.269661, 34.347649);
  LatLng _curPos = const LatLng(53.269661, 34.347649);
  late GoogleMapController _mapController;
  Location _location = Location();
  bool styleChanged = false;
  final List<Marker> _markers = [];

  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  Marker? _pathMarker = null;

  _showLocOnMap(LatLng latlng) {
    _markers.clear();
    setState(() {
      _center = latlng;
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(_center.toString()),
        position: _center,
        onTap: () {
          _openMarker(MarkerId(_center.toString()));
        },
      );
      _markers.add(marker);
      pageType = 'map';
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      controller.setMapStyle(string);
      setState(() {
        styleChanged = true;
      });
    });

    _mapController = controller;
    _location.onLocationChanged.listen((l) {
      _curPos = LatLng(l.latitude!, l.longitude!);

      _drawPath();
    });

    _mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _center, zoom: 15)));
  }

  _openMarker(MarkerId markerId) {
    Marker curMark = _markers.firstWhere((m) => m.markerId == markerId);

    showDialog(
      context: context,
      builder: (_) => MarkerPopupWidget(
          curMark: curMark,
          deleteMarker: _deleteMarker,
          drawPath: _drawMarkerPath),
    );
  }

  _deleteMarker(Marker mark) {
    setState(() {
      _markers.remove(mark);
      _pathMarker=null;
      _polylines.clear();
    });
  }

  _drawMarkerPath(Marker mark) {
    setState(() {
      _pathMarker = mark;
    });
    _drawPath();
  }

  _drawPath() async {
    if (_pathMarker != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBXHvMXQfB5NfrtrCpVxzIClhk8ni1lNiA',
        PointLatLng(_curPos.latitude, _curPos.longitude),
        PointLatLng(
            _pathMarker!.position.latitude, _pathMarker!.position.longitude),
      );

      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      setState(() {
        Polyline polyline = Polyline(
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates);
        _polylines.clear();
        _polylines.add(polyline);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courier prototype'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange[100],
      body: Stack(
        children: (() {
          switch (pageType) {
            case "curOrder":
              if (orderAccepted) {
                return <Widget>[
                  AcceptedOrder(order: curOrder),
                ];
              }
              return <Widget>[
                NewOrder(order: curOrder),
              ];
            case "map":
              return <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: _onMapCreated,
                  markers: _markers.toSet(),
                  polylines: _polylines,
                ),
                (() {
                  if (styleChanged == false) {
                    return Container(
                      color: Colors.orange[100],
                      height: double.infinity,
                      width: double.infinity,
                      child: Align(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }()),
              ];
            default:
              return <Widget>[];
          }
        }()),
      ),
      bottomNavigationBar: new BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Row(
              children: [
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.delivery_dining),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: (() {
                    if (pageType == "curOrder") {
                      return Colors.white;
                    }
                    return Colors.orange[100];
                  }()),
                  onPressed: () {
                    setState(() {
                      pageType = "curOrder";
                    });
                  },
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.map_sharp),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: (() {
                    if (pageType == "map") {
                      return Colors.white;
                    }
                    return Colors.orange[100];
                  }()),
                  onPressed: () {
                    setState(() {
                      pageType = "map";
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            )),
      ),
    );
  }
}
