import 'package:flutter/material.dart';
import 'package:homero/screens/services/selected_service_view.dart';

import '../../../models/package_model.dart';
import '../../package/selected_package_screen.dart';

class PackageWidget extends StatelessWidget {
  PackageModel package;
  Color color;
  PackageWidget({required this.color,required this.package});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, SelectedPackageView.routeName,arguments: package);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 35,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          package.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
