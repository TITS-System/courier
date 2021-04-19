import 'package:courier_prototype/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'order.dart';

class NewOrder extends StatefulWidget {
  final OrderWidget? order;
  const NewOrder({Key? key, this.order}) : super(key: key);

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.order!,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {},
                  child: Text('accept'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
