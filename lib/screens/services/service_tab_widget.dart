import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceTabWidget extends StatelessWidget{
  String name;
  bool isSelected;
  ServiceTabWidget({required this.name,required this.isSelected});
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Text(name,style: TextStyle(
          color: isSelected?Theme.of(context).textTheme.bodySmall!.color:Color.fromARGB(
              255, 126, 127, 131),
          fontSize: 15,
          fontWeight: isSelected?FontWeight.w600:FontWeight.w400,
          decoration: isSelected?TextDecoration.underline:TextDecoration.none,
        ),),
    );
  }
}