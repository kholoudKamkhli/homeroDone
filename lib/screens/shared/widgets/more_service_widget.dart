import 'package:flutter/material.dart';
import 'package:homero/screens/shared/widgets/service_widget.dart';

import '../../services/services_view.dart';

class MoreServiceWidget extends ServiceWidget {
  MoreServiceWidget({required super.service, required super.title, required super.imagePath});




  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ServicesView.routeName,arguments: service.id);
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 184, 181, 181)
          ),
          width: 90,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,color: Colors.black54

                    ,size:12 ,),
                  SizedBox(width: 4,),
                  Text("More",style: TextStyle(
                      color: Colors.black54,
                    fontSize:12 ,
                    fontWeight: FontWeight.w400,
                  ),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
