import 'package:flutter/material.dart';
import '/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  final bool isFavorited;
  @override
  ProductGrid(this.isFavorited);
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        isFavorited ? productsData.favoriteLis : productsData.items;
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) =>
            ChangeNotifierProvider.value(
              value: products[index],
              child: Container(
                child: ProductItem(),
                padding: EdgeInsets.all(5),
              ),
            ));
  }
}
