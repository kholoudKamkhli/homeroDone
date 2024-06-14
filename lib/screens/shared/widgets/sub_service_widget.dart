import 'package:flutter/material.dart';
import 'package:homero/screens/workers/worker_view.dart';

import '../../../models/service_model.dart';

class SubServiceWidget extends StatelessWidget {
  SubServiceModel subservice;
  SubServiceWidget({required this.subservice});
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, WorkerView.routeName,
          arguments: {
          'subService': subservice,
          'package': null,
        },
          //arguments: subservice
        );
      },
      child: Card(
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
                child: Image.network(subservice.imageUrl),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  subservice.title,
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
