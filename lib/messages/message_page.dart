import 'package:courier_prototype/api_work/api_worker.dart';
import 'package:courier_prototype/messages/message_widget.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<MessageW> messages = [];
  final messageController = TextEditingController();

  _initializeMessages() async {
    List<MessageW> messagesWait;

    messagesWait = await getMessages();

    setState(() {
      messages = messagesWait;
    });
  }

  @override
  void initState() {
    _initializeMessages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                  Container(height: 20),
                  RichText(
                      text: TextSpan(
                          text: ' ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent,
                              fontSize: 30))),
                ] +
                messages +
                <Widget>[
                  Container(height: 30),
                  RichText(
                      text: TextSpan(
                          text: ' ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent,
                              fontSize: 30))),
                ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 255, 105, 0), width: 2)),
              ),
              child: RichText(
                  text: TextSpan(
                      text: 'Administrator: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 105, 0),
                          fontSize: 30))),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: Color.fromARGB(255, 255, 105, 0), width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Enter",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send,
                        color: Color.fromARGB(255, 255, 105, 0)),
                    onPressed: () {
                      sendMessage(messageController.text).then((value) {_initializeMessages();});
                      messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
