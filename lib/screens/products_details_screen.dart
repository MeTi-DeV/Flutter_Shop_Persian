import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'package:persian_tools/persian_tools.dart';

class ProductsDetailsScreen extends StatelessWidget {
  static const routeName = 'product-details';
  @override
  Widget build(BuildContext context) {
    final productsId = ModalRoute.of(context)!.settings.arguments as String;
    final loadProduct =
        Provider.of<Products>(context, listen: false).findById(productsId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade700,
        title: Text(loadProduct.title),
      ),
      body: Column(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            child: ClipRRect(
              child: Image.network(
                loadProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            loadProduct.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    child: Flexible(
                      child: Container(
                        width: 200,
                        child: Text(
                          loadProduct.description,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 18, overflow: TextOverflow.visible),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    convertEnToFa(
                        '${loadProduct.price.toStringAsFixed(0)} تومان'
                            .addComma),
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
