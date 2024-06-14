import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderTabWidget extends StatelessWidget{
  String name;
  bool isSelected;
  OrderTabWidget({required this.name,required this.isSelected});
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(name,style: TextStyle(
        color: isSelected?Theme.of(context).textTheme.bodySmall!.color:const Color.fromARGB(
            255, 126, 127, 131),
        fontSize: 15,
        fontWeight: isSelected?FontWeight.w600:FontWeight.w400,
        decoration: isSelected?TextDecoration.underline:TextDecoration.none,
      ),),
    );
  }
}