import 'package:courier_prototype/api_work/api_worker.dart';
import 'package:courier_prototype/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'order.dart';

class NewOrder extends StatefulWidget {
  final OrderWidget? order;
  final Function? remMar;
  final Function? initOrds;
  const NewOrder({Key? key, this.order,this.initOrds,this.remMar}) : super(key: key);

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
        color: Color.fromARGB(0, 255, 105, 0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Color.fromARGB(255, 255, 105, 0), width: 3),
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
                  onPressed: () {
                    acceptOrder(widget.order!.order!.id,widget.initOrds!,widget.remMar!);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'accept',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
