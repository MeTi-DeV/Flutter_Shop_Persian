import 'package:flutter/material.dart';
import 'package:persian_tools/persian_tools.dart';

//comment 1 : create this widget as Cart Badge on app Bar
class Badge extends StatefulWidget {
  const Badge({
    // required Key key,
    required this.child,
    required this.value,
    // required this.color,
  });
  //  : super(key: key);

  final Widget child;
  final String value;

  @override
  State<Badge> createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.0),
              // color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child:  Text(
              convertEnToFa(widget.value),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
