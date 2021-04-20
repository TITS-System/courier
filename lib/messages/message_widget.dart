import 'package:flutter/material.dart';

class MessageW extends StatefulWidget {
  final String? text;
  const MessageW({Key? key, this.text}) : super(key: key);

  @override
  _MessageWState createState() => _MessageWState();
}

class _MessageWState extends State<MessageW> {
  @override
  Widget build(BuildContext context) {
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
  }
}
