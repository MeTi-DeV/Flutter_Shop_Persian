import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:provider/provider.dart';
import '../screens/user_products_screen.dart';
import '../screens/order_screen.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/main_dreawer.dart';

class MainDreawerSecond extends StatefulWidget {
  final Widget bodyDreawer;
  final Widget adderButton;
  final String titleDrawer;
  MainDreawerSecond({
    required this.bodyDreawer,
    required this.titleDrawer,
    required this.adderButton,
  });
  @override
  _MainDreawerSecondState createState() => _MainDreawerSecondState();
}

class _MainDreawerSecondState extends State<MainDreawerSecond> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);
    return AdvancedDrawer(
      backdropColor: Colors.pink[800],
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 25.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              widget.adderButton,
              Consumer<Cart>(
                builder: (context, cart, ch) => Badge(
                  child: ch as Widget,
                  value: cart.itemsCount.toString(),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                ),
              ),
            ],
            title: Text(widget.titleDrawer),
            backgroundColor: Colors.pink[800],
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
          ),
          body: widget.bodyDreawer),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Image.network(
                      'https://avatars.githubusercontent.com/u/60173619?v=4'),
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 20,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('???????? ??????????',
                          style: PersianFonts.Samim.copyWith(
                              color: Colors.white, fontSize: 25)),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/cart');
                  },
                  leading: Icon(Icons.shopping_cart_rounded),
                  title: Text('?????? ???????? '),
                  trailing: Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    child: Consumer<Cart>(
                        builder: (context, cart, ch) => Text(
                              convertEnToFa('${cart.itemsCount}'),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(MainDreawerFirst.routeName);
                  },
                  leading: Icon(Icons.shopping_bag_rounded),
                  title: Text('??????????????'),
                ),
                Divider(
                  color: Colors.black26,
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(OrderScreen.routeName),
                  leading: Icon(Icons.event_available_rounded),
                  title: Text('???????????????? ????'),
                ),
                Divider(
                  color: Colors.black26,
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(UserProductsScreen.routeName),
                  leading: Icon(Icons.add_shopping_cart_rounded),
                  title: Text('???????????? ??????????????'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child:
                        Text('?????????? ?????????????? ???? ?????????? | ?????????? ?????? ???????? ??????????'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
