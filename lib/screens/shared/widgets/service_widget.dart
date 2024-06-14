import 'package:flutter/material.dart';
import 'package:homero/screens/services/selected_service_view.dart';

import '../../../models/service_model.dart';


class ServiceWidget extends StatelessWidget {
  ServiceModel service;
  String imagePath;
  String title;

    ServiceWidget({required this.service,required this.title,required this.imagePath});
  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, SelectedServiceView.routeName,arguments: service);
      },
      child: Card(
        color: Theme.of(context).cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: 90,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   imagePath,
              //   width: MediaQuery.of(context).size.width * 0.7,
              //   height: MediaQuery.of(context).size.height * 0.7,
              // ),
              Container(
                height: 34,
                width: 34,
                child: Image.network(imagePath),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
