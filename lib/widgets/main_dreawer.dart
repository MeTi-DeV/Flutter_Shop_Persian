import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:my_shop/screens/order_screen.dart';
import 'package:my_shop/screens/user_products_screen.dart';
import 'package:my_shop/widgets/product_grid.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

enum FavoriteOptions { All, Favorite }

class MainDreawerFirst extends StatefulWidget {
  @override
  _MainDreawerFirstState createState() => _MainDreawerFirstState();
  static const routeName = '/';
}

class _MainDreawerFirstState extends State<MainDreawerFirst> {
  var _selectFavorites = false;
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
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
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
              backgroundColor: Colors.pink[800],
              actions: [
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
                PopupMenuButton(
                  onSelected: (FavoriteOptions selectedValue) {
                    setState(() {
                      if (selectedValue == FavoriteOptions.Favorite) {
                        _selectFavorites = true;
                      } else {
                        _selectFavorites = false;
                      }
                    });
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text('نمایش علاقه مندی ها'),
                        value: FavoriteOptions.Favorite),
                    PopupMenuItem(
                        child: Text('نمایش همه محصولات'),
                        value: FavoriteOptions.All),
                  ],
                ),
              ],
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
            body: ProductGrid(_selectFavorites)),
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
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/cart');
                    },
                    leading: Icon(Icons.shopping_cart_rounded),
                    title: Text('سبد خرید '),
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
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(OrderScreen.routeName),
                    leading: Icon(Icons.event_available_rounded),
                    title: Text('صورتحساب ها'),
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(UserProductsScreen.routeName),
                    leading: Icon(Icons.add_shopping_cart_rounded),
                    title: Text('مدیریت محصولات'),
                  ),
                  Divider(
                    color: Colors.black26,
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
                          Text('شرایط استفاده از خدمات | سیاست حفظ حریم خصوصی'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
