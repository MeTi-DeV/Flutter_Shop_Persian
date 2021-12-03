import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persian_tools/persian_tools.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.productId,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Column(
        children: [
          Dismissible(
            confirmDismiss: (direction) {
              return
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text('حذف از سبد خرید'),
                        content: Text('آیا می خواهید محصول را حذف کنید؟'),
                        actions: [
                          FlatButton(
                          color: Colors.red[100],
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text(
                              'خیر',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          FlatButton(
                            color: Colors.blue[100],
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: Text(
                              'بله',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ));
            },
            background: Container(
              color: Theme.of(context).errorColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'حذف از سبد خرید',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              Provider.of<Cart>(context, listen: false)
                  .cartRemoveToggle(productId);
            },
            key: ValueKey(id),
            child: ListTile(
              trailing: CircleAvatar(
                  backgroundColor: Colors.cyan[900],
                  child: FittedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          convertEnToFa('${quantity} '),
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'x',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  )),
              leading: Container(
                child: Text(title,
                    style: PersianFonts.Vazir.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              title: Text(
                convertEnToFa(
                    '${(quantity * price).toStringAsFixed(0).addComma}'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              subtitle: Text(
                convertEnToFa('${price.toStringAsFixed(0).addComma}' +
                    ' x ' +
                    '${quantity}'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
