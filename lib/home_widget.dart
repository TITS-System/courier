import 'package:courier_prototype/messages/message_page.dart';
import 'package:courier_prototype/order/order.dart';
import 'package:courier_prototype/order/order_accepted_widget.dart';
import 'package:courier_prototype/order/order_widget.dart';
import 'package:courier_prototype/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'api_work/api_worker.dart';
import 'markers/marker_cur_popup.dart';
import 'markers/marker_new_popup.dart';
import 'order/order_new_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String pageType = "orders";
  bool orderAccepted = false;
  late OrderWidget curOrder;
  LatLng _center = const LatLng(53.269661, 34.347649);
  LatLng _curPos = const LatLng(53.269661, 34.347649);
  late GoogleMapController _mapController;
  Location _location = Location();
  bool styleChanged = false;
  final Set<Marker> _markers = {};
  List<NewOrder> newOrdersW = [];
  List<AcceptedOrder> acceptedOrdersW = [];

  Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  Set<Marker> _pathMarker = {};

  _showCurOrdOnMap(LatLng latlng) {
    setState(() {
      _center = latlng;
      final marker = Marker(
        markerId: MarkerId(latlng.toString()),
        position: _center,
        onTap: () {
          _openCurMarker(MarkerId(latlng.toString()));
        },
      );
      _markers.add(marker);
      pageType = 'map';
    });
  }

  _showNewOrdOnMap(LatLng latlng) {
    setState(() {
      _center = latlng;
      final marker = Marker(
        alpha: 0.5,
        markerId: MarkerId(latlng.toString()),
        position: _center,
        onTap: () {
          _openNewMarker(MarkerId(latlng.toString()));
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

  _openCurMarker(MarkerId markerId) {
    Marker curMark = _markers.firstWhere((m) => m.markerId == markerId);

    showDialog(
      context: context,
      builder: (_) =>
          MarkerCurPopupWidget(curMark: curMark, drawPath: _drawMarkerPath),
    );
  }

  _openNewMarker(MarkerId markerId) {
    Marker curMark = _markers.firstWhere((m) => m.markerId == markerId);

    showDialog(
      context: context,
      builder: (_) => MarkerNewPopupWidget(
        curMark: curMark,
        deleteMarker: _deleteMarker,
      ),
    );
  }

  _deleteMarker(Marker mark) {
    setState(() {
      _markers.remove(mark);
      _pathMarker.remove(mark);
      _polylines.clear();
      _drawPath();
    });
  }

  _drawMarkerPath(Marker mark) {
    setState(() {
      if (_pathMarker.contains(mark)) {
        _pathMarker.remove(mark);
      } else {
        _pathMarker.add(mark);
      }
    });
    _drawPath();
  }

  _drawPath() async {
    //List<Polyline> polylines=[];
    _polylines.clear();

    LatLng lastPos = LatLng(_curPos.latitude, _curPos.longitude);
    if (_pathMarker.length > 0) {
      await Future.forEach(_pathMarker, (Marker marker) async {
        List<LatLng> polylineCoordinates = [];

        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyBXHvMXQfB5NfrtrCpVxzIClhk8ni1lNiA',
          PointLatLng(lastPos.latitude, lastPos.longitude),
          PointLatLng(marker.position.latitude, marker.position.longitude),
        );

        if (result.points.isNotEmpty) {
          polylineCoordinates.clear();
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }

        lastPos = LatLng(marker.position.latitude, marker.position.longitude);
        Polyline polyline = Polyline(
            polylineId: PolylineId("poly" + marker.position.toString()),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates);
        _polylines.add(polyline);
      });
      setState(() {
        _polylines = _polylines;
      });
    }
  }

  _initializeOrders() async {
    // curOrder = OrderWidget(
    //   order: Order('pizza', LatLng(53.307931, 34.301674), 'кв.10'),
    //   showOnMap: _showCurOrdOnMap,
    // );
    // acceptedOrdersW.add(AcceptedOrder(order: curOrder));
    // curOrder = OrderWidget(
    //   order: Order('pizza', LatLng(54.307931, 34.301674), 'кв.10'),
    //   showOnMap: _showNewOrdOnMap,
    // );
    // newOrdersW.add(NewOrder(order: curOrder));
    // newOrdersW.add(NewOrder(order: curOrder));
    // 
    Set<AcceptedOrder> ordsCur = await getActiveOrders(1);

    Set<Order> ords = await getNewOrders(1);
    setState(() {
      acceptedOrdersW.clear();
      acceptedOrdersW.addAll(ordsCur);

      newOrdersW.clear();
      newOrdersW.addAll(ords.map((e) =>
          NewOrder(order: OrderWidget(order: e, showOnMap: _showNewOrdOnMap))));
    });
  }

  @override
  void initState() {
    _initializeOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 10,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: (() {
          switch (pageType) {
            case "orders":
              return <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                _initializeOrders();
                              },
                              child: Text('Update')),
                          (() {
                            if (acceptedOrdersW.length > 0) {
                              return RichText(
                                  text: TextSpan(
                                      text: 'Current orders:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          color: Colors.black)));
                            }
                            return Container();
                          }())
                        ] +
                        acceptedOrdersW +
                        <Widget>[
                          (() {
                            if (newOrdersW.length > 0) {
                              return RichText(
                                  text: TextSpan(
                                      text: 'New orders:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          color: Colors.black)));
                            }
                            return Container();
                          }())
                        ] +
                        newOrdersW,
                  ),
                ),
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
                    polylines: _polylines),
                (() {
                  if (styleChanged == false) {
                    return Container(
                      color: Color.fromARGB(155, 255, 105, 0),
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
            case "profile":
              return <Widget>[
                ProfileWidget(),
              ];
            case "messages":
              return <Widget>[
                MessagePage(),
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
              color: Colors.white,
            ),
            child: Row(
              children: [
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.delivery_dining),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: (() {
                    if (pageType == "orders") {
                      return Color.fromARGB(255, 255, 105, 0);
                    }
                    return Color.fromARGB(155, 255, 105, 0);
                  }()),
                  onPressed: () {
                    setState(() {
                      pageType = "orders";
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
                      return Color.fromARGB(255, 255, 105, 0);
                    }
                    return Color.fromARGB(155, 255, 105, 0);
                  }()),
                  onPressed: () {
                    setState(() {
                      pageType = "map";
                    });
                  },
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.person),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: (() {
                    if (pageType == "profile") {
                      return Color.fromARGB(255, 255, 105, 0);
                    }
                    return Color.fromARGB(155, 255, 105, 0);
                  }()),
                  onPressed: () {
                    setState(() {
                      pageType = "profile";
                    });
                  },
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.message),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: (() {
                    if (pageType == "messages") {
                      return Color.fromARGB(255, 255, 105, 0);
                    }
                    return Color.fromARGB(155, 255, 105, 0);
                  }()),
                  onPressed: () {
                    setState(() {
                      pageType = "messages";
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
