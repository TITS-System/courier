import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(),
        RichText(
            text: TextSpan(
          text: 'Иван',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        )),
        Container(height: 40),
        Row(
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {},
                child: RichText(
                    text: TextSpan(
                  text: 'SOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                )),
              ),
            ),
            Expanded(flex: 1, child: Container()),
          ],
        ),
        Container(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(0, 255, 105, 0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border:
                Border.all(color: Color.fromARGB(255, 255, 105, 0), width: 3),
          ),
          child: RichText(
              text: TextSpan(
            text: 'пройдено: 35км',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          )),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(0, 255, 105, 0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border:
                Border.all(color: Color.fromARGB(255, 255, 105, 0), width: 3),
          ),
          child: RichText(
              text: TextSpan(
            text: 'показать путь за сегодня',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
            ),
          )),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(0, 255, 105, 0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border:
                Border.all(color: Color.fromARGB(255, 255, 105, 0), width: 3),
          ),
          child: RichText(
              text: TextSpan(
            text: 'средняя скорость: 8 км/ч',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          )),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(0, 255, 105, 0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border:
                Border.all(color: Color.fromARGB(255, 255, 105, 0), width: 3),
          ),
          child: RichText(
              text: TextSpan(
            text: 'среднее время выполнения заказа: 32 мин',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          )),
        ),
      ],
    ));
  }
}
