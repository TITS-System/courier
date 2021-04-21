import 'package:flutter/material.dart';

class MessageW extends StatefulWidget {
  final String? text;
  final String? time;
  final bool? isFromCourier;

  const MessageW({Key? key, this.text, this.time, this.isFromCourier})
      : super(key: key);

  @override
  _MessageWState createState() => _MessageWState();
}

class _MessageWState extends State<MessageW> {
  @override
  Widget build(BuildContext context) {
    return (() {
      if (widget.isFromCourier!) {
        return Row(
          children: [
            Expanded(child: Container()),
            Container(
                constraints: BoxConstraints( maxWidth: 300),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(155, 55, 179, 74),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                        text: widget.text,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)))),
          ],
        );
      }
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(155, 255, 105, 0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: RichText(
            text: TextSpan(
                text: widget.text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20))),
      );
    }());

    return Container();
  }
}
