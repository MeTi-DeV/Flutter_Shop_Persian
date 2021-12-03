import 'package:flutter/material.dart';
import '/providers/order.dart';
import '/screens/cart_screen.dart';
import 'package:my_shop/screens/order_screen.dart';
import './widgets/main_dreawer.dart';
import 'package:persian_fonts/persian_fonts.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './screens/products_details_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Order()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: PersianFonts.shabnamTextTheme,
          primaryColor: Colors.purpleAccent.shade700,
          accentColor: Colors.lightGreenAccent.shade700,
        ),
        debugShowCheckedModeBanner: false,
        home: MainDreawerFirst(),

        routes: {
          OrderScreen.routeName: (ctx) => OrderScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductsDetailsScreen.routeName: (ctx) => ProductsDetailsScreen()
        },
      ),
    );
  }
}
