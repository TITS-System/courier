import 'dart:convert';

import 'package:courier_prototype/api_work/api_worker.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late StatsDto statDto=StatsDto(paths: [],averageDeliveryTime: 0,averageDistance: 0,averageSpeed: 0,canceledDeliveriesCount: 0,totalDistance: 0,finishedDeliveriesCount: 0);

  setStatDto() async {
    statDto = await getStats();
    setState(() {
      statDto = statDto;
    });
  }

  @override
  void initState() {
    setStatDto();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(),
        RichText(
            text: TextSpan(
          text: ' ',//'Иван',
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
                onPressed: () {
                  sendSos();
                },
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
            text: 'пройдено: ${(statDto.totalDistance*100).toInt()/100.0} м',
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
            text: 'средняя скорость: ${(statDto.averageSpeed*100).toInt()/100.0} м/с',
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
            text: 'среднее время выполнения заказа: ${(statDto.averageDeliveryTime*100).toInt()/100.0} с',
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
