import 'package:flutter/material.dart';
import 'package:courier_prototype/api_work/api_worker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowOnMapWidget extends StatefulWidget {
  final List<List<LatLngDto?>?>? path;

  const ShowOnMapWidget({Key? key, this.path}) : super(key: key);

  @override
  _ShowOnMapWidgetState createState() => _ShowOnMapWidgetState();
}

class _ShowOnMapWidgetState extends State<ShowOnMapWidget> {
  Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  late GoogleMapController _mapController;
  LatLng _center = const LatLng(53.269661, 34.347649);
  Set<Marker> _markers = {};

  _drawPath() async {
    _polylines.clear();

    await Future.forEach(widget.path!, (List<LatLngDto?>? orderPath) async {
      print(orderPath);
      if (orderPath!.length > 0) {
        LatLng lastPos = LatLng(orderPath!.first!.lat, orderPath!.first!.lng);
        await Future.forEach(orderPath!, (LatLngDto? marker) async {
          print(marker!.toJson());
          print(
            _markers.add(
              Marker(
                  markerId: MarkerId(marker!.toJson().toString()),
                  position: LatLng(marker!.lat, marker!.lng)),
            ),
          );
          List<LatLng> polylineCoordinates = [];

          PolylineResult result =
              await polylinePoints.getRouteBetweenCoordinates(
            'AIzaSyBXHvMXQfB5NfrtrCpVxzIClhk8ni1lNiA',
            PointLatLng(lastPos.latitude, lastPos.longitude),
            PointLatLng(marker!.lat, marker!.lng),
          );

          print("REZ:"+result.points.isNotEmpty.toString());

          if (result.points.isNotEmpty) {
            polylineCoordinates.clear();
            result.points.forEach((PointLatLng point) {
              polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            });
          }

          print(polylineCoordinates);

          lastPos = LatLng(marker!.lat, marker!.lng);
          Polyline polyline = Polyline(
              polylineId: PolylineId("poly" + marker!.toString()),
              color: Color.fromARGB(255, 40, 122, 198),
              points: polylineCoordinates);
          setState(() {
            _polylines.add(polyline);
          });

          print(orderPath.length);
          print(_polylines);
        });
        setState(() {
          print(_polylines.last.points);
          print(_markers);
          print("ADDDED");
          _polylines = _polylines;
          _markers=_markers;
        });
      }
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _drawPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          markers: _markers,
          polylines: _polylines),
    );
  }
}
