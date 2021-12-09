import 'package:flutter/material.dart';
import './screens/edit_product_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:my_shop/screens/order_screen.dart';
import 'package:provider/provider.dart';
import '/providers/order.dart';
import '/screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './widgets/main_dreawer.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './screens/products_details_screen.dart';

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
          appBarTheme: AppBarTheme(color: Colors.pink[800]),
          textTheme: PersianFonts.shabnamTextTheme,
          primaryColor: Colors.purpleAccent.shade700,
          accentColor: Colors.lightGreenAccent.shade700,
        ),
        debugShowCheckedModeBanner: false,
        home: MainDreawerFirst(),
        routes: {
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductsDetailsScreen.routeName: (ctx) => ProductsDetailsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen()
        },
      ),
    );
  }
}
