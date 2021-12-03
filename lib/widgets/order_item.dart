import 'dart:math';
import 'package:flutter/material.dart';
import 'package:persian_tools/persian_tools.dart';
import '../providers/order.dart' as orde;
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderItem extends StatefulWidget {
  final orde.OrderItem order;
  OrderItem(this.order);
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var isShowmore = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              convertEnToFa(
                  'مبلغ قابل پرداخت ${widget.order.amount.toStringAsFixed(0)}'
                      .addComma),
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              '${widget.order.time.toPersianDateStr(showDayStr: true)}',
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    isShowmore = !isShowmore;
                  });
                },
                icon: !isShowmore
                    ? Icon(Icons.expand_more)
                    : Icon(Icons.expand_less)),
          ),
          if (isShowmore)
            Container(
              height: min(widget.order.products.length * 20 + 10, 100),
              child: ListView(
                children: [
                  ...widget.order.products.map(
                    (prod) => Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${prod.title}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            convertEnToFa('${prod.quantity}' +
                                ' x ' +
                                '${prod.price.toStringAsFixed(0)}'),
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            convertEnToFa(
                                '${(prod.price * prod.quantity).toStringAsFixed(0)}'),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
