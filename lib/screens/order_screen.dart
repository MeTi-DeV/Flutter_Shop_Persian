import 'package:flutter/material.dart';
import 'package:my_shop/widgets/main_dreawer_second.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../providers/order.dart' show Order;

class OrderScreen extends StatelessWidget {
  static const routeName = 'order-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return MainDreawerSecond(
      titleDrawer: 'صورتحساب',
      bodyDreawer: Scaffold(
        body: orderData.orders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_task_rounded,
                      color: Colors.redAccent[400],
                      size: 100,
                    ),
                    Text(
                      'صورتحساب شما در حال حاظر خالی است',
                      style: PersianFonts.Samim.copyWith(fontSize: 18),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (BuildContext context, int index) => OrderItem(
                  orderData.orders[index],
                ),
              ),
      ),
    );
  }
}
