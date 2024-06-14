import 'package:flutter/material.dart';

import 'oder_tab_widget.dart';
import 'order_widget.dart';

class OrderTabsWidget extends StatefulWidget {
  List<OrderWidget>orders;
  OrderTabsWidget({required this.orders});

  @override
  State<OrderTabsWidget> createState() => _OrderTabsWidgetState();
}

class _OrderTabsWidgetState extends State<OrderTabsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: widget.orders.length,
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              tabs: widget.orders
                  .map((e) => OrderTabWidget(
                name: e.name ?? "",
                isSelected: selectedIndex == widget.orders.indexOf(e)
                    ? true
                    : false,
              ))
                  .toList(),
              isScrollable: true,
              indicatorColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
