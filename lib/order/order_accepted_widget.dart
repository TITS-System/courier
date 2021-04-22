import 'package:courier_prototype/api_work/api_worker.dart';
import 'package:courier_prototype/order/order_widget.dart';
import 'package:flutter/material.dart';

class AcceptedOrder extends StatefulWidget {
  final int? deliveryId;
  final OrderWidget? order;
  final Function? remMark;
  final Function? initOrds;
  const AcceptedOrder({Key? key, this.order, this.deliveryId,this.initOrds,this.remMark})
      : super(key: key);

  @override
  _AcceptedOrderState createState() => _AcceptedOrderState();
}

class _AcceptedOrderState extends State<AcceptedOrder> {
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
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 240, 25, 0)),
                  onPressed: () {
                    cancelOrder(widget.deliveryId!,widget.initOrds!,widget.remMark!,widget.order!.order!.id);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'cancel',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 55, 179, 74)),
                  onPressed: () {
                    finishOrder(widget.deliveryId!,widget.initOrds!,widget.remMark!,widget.order!.order!.id);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'finish',
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
