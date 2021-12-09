import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persian_tools/persian_tools.dart';
import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProducts extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  UserProducts(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(
              convertEnToFa(
                '${price.toStringAsFixed(0)} تومان'.addComma,
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl.toString()),
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id),
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () =>
                        Provider.of<Products>(context, listen: false)
                            .removeProduct(id),
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
