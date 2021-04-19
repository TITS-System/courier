import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerCurPopupWidget extends StatefulWidget {
final Marker? curMark;
final Function? drawPath;
const MarkerCurPopupWidget(
      { Key? key,this.curMark,this.drawPath}) 
      : super(key: key);

  @override
  _MarkerCurPopupWidgetState createState() => _MarkerCurPopupWidgetState();
}

class _MarkerCurPopupWidgetState extends State<MarkerCurPopupWidget> {
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
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      widget.drawPath!(widget.curMark);
                      Navigator.of(context).pop();
                    },
                    child: Text('Add/remove from path'),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
