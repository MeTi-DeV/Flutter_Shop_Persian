import 'package:flutter/material.dart';
import 'package:my_shop/screens/order_screen.dart';
import 'package:my_shop/widgets/cart_item.dart';
import 'package:my_shop/widgets/main_dreawer_second.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/order.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orderData = Provider.of<Order>(context);
    return MainDreawerSecond(
      bodyDreawer: Scaffold(
        body: cart.items.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_business_rounded,
                      color: Colors.redAccent[400],
                      size: 100,
                    ),
                    Text(
                      'سبد خرید شما در حال حاظر خالی است',
                      style: PersianFonts.Samim.copyWith(fontSize: 20),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Card(
                    child: Container(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      'مبلغ قابل پرداخت :',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        convertEnToFa(
                                            '${cart.totalPrice.toStringAsFixed(0)}'
                                                .addComma),
                                        style: PersianFonts.Vazir.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      ' تومان',
                                      style: PersianFonts.Vazir.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            RaisedButton(
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'صورتحساب',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    OrderScreen.routeName);
                                orderData.addToOrders(
                                    cart.items.values.toList(),
                                    cart.totalPrice);
                                cart.clearCart();
                              },
                              color: Colors.pink[900],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartItem(
                          id: cart.items.values.toList()[index].id,
                          title: cart.items.values.toList()[index].title,
                          quantity: cart.items.values.toList()[index].quantity,
                          price: cart.items.values.toList()[index].price,
                          productId: cart.items.keys.toList()[index],
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
      titleDrawer: 'سبد خرید',
    );
  }
}
