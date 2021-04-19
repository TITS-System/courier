import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerPopupWidget extends StatefulWidget {
final Marker? curMark;
final Function? deleteMarker;
final Function? drawPath;
const MarkerPopupWidget(
      { Key? key,this.curMark,this.deleteMarker,this.drawPath}) 
      : super(key: key);

  @override
  _MarkerPopupWidgetState createState() => _MarkerPopupWidgetState();
}

class _MarkerPopupWidgetState extends State<MarkerPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text('Point'),
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      widget.deleteMarker!(widget.curMark);
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      widget.drawPath!(widget.curMark);
                      Navigator.of(context).pop();
                    },
                    child: Text('Draw Path'),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
