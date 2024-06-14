import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  String name;
  OrderWidget({required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}
