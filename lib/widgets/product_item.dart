import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../screens/products_details_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductsDetailsScreen.routeName,
                arguments: productData.id),
            child: Image.network(
              productData.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                productData.title,
                textAlign: TextAlign.center,
              ),
              leading: IconButton(
                onPressed: () {
                  cartData.addToCart(
                      productData.id, productData.title, productData.price);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content:
                        Text('${productData.title}به سبد خرید شما اضافه شد'),
                    action: SnackBarAction(
                        label: 'بازگردانی',
                        onPressed: () =>
                            cartData.SingleRemoveItem(productData.id)),
                  ));
                },
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.pinkAccent[100],
                ),
              ),
              trailing: Consumer<Product>(
                  builder: (context, product, _) => IconButton(
                        onPressed: () => product.isFavoriteToggle(),
                        icon: Icon(
                            product.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: Colors.lightGreenAccent[400]),
                      ))),
        ),
      ),
    );
  }
}
