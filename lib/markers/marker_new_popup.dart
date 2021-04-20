import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerNewPopupWidget extends StatefulWidget {
  final Marker? curMark;
  final Function? deleteMarker;
  const MarkerNewPopupWidget({Key? key, this.curMark, this.deleteMarker})
      : super(key: key);

  @override
  _MarkerNewPopupWidgetState createState() => _MarkerNewPopupWidgetState();
}

class _MarkerNewPopupWidgetState extends State<MarkerNewPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Point'),
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    widget.deleteMarker!(widget.curMark);
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
