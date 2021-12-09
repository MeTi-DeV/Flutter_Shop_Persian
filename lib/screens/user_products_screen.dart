import 'package:flutter/material.dart';
import 'package:my_shop/widgets/main_dreawer_second.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_products.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).items;
    return MainDreawerSecond(
        adderButton: IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: Icon(Icons.add)),
        bodyDreawer: productsData.length == 0
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_business_rounded,
                      color: Colors.cyanAccent[700],
                      size: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'کالا خود را اضافه کنید',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: productsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      UserProducts(
                        id: productsData[index].id,
                        title: productsData[index].title,
                        imageUrl: productsData[index].imageUrl,
                        price: productsData[index].price,
                      ),
                    ],
                  );
                },
              ),
        titleDrawer: 'مدیریت محصولات');
  }
}
