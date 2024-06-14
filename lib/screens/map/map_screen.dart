import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homero/controllers/database/notification_database.dart';
import 'package:homero/models/notifications_model.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';

import '../../controllers/database/order_database.dart';
import '../shared/dialog_utils.dart';



class MapScreen extends StatefulWidget {
  static const String routeName = "mapScreen";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? pickUpPoint;
  var latLang;
  var first;

  @override
  Widget build(BuildContext context) {
    var order = ModalRoute.of(context)?.settings!.arguments as OrderModel;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.8,
            child: GoogleMap(
              initialCameraPosition:
                  const CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14),
              markers: {
                if (pickUpPoint != null) pickUpPoint!,
              },
              onLongPress: addMarker,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(24, 255, 255, 255),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text("choose pick up point then click on continue",style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: ()async{
                    try{
                      if(pickUpPoint!=null){
                        var pos=pickUpPoint!.position;
                        final coordinates =
                        Coordinates(pos.latitude,pos.longitude);
                        var address =
                        await Geocoder.local.findAddressesFromCoordinates(coordinates);
                        first = address.first;
                        order.pickUpPoint=first?.addressLine?.toString();
                        OrderDatabase.addOrder(order);
                        NotificationModel notification = NotificationModel(content: "You Successfully Ordered ${order.serviceName} from worker ${order.workerName} and your order will be delivered within 2 days ", date: order.date);
                        NotificationDatabase.addNotification(FirebaseAuth.instance.currentUser!.uid, notification);
                        MyDialogUtils.showAnotherMessage(context, "Your Order has been placed successfuly ", "Ok",posAction: (){
                          Navigator.pushNamed(context, HomeScreenView.routeName);
                        });
                        //Navigator.pushNamed(context, HomeScreenView.routeName);
                      }
                    }
                    catch(e){

                    }

                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    height: 58,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 52, 205, 196),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  addMarker(LatLng pos) {
    {

      pickUpPoint = Marker(
        onDragEnd: (LatLng newPos) async {
          latLang = newPos;
          final coordinates =
           Coordinates(latLang.latitude,latLang.longitude);
          var address =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
           first = address.first;

        },
        markerId: const MarkerId("pick up point"),
        infoWindow: const InfoWindow(title: "Pick Up Point"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        position: pos,
      );
    }
    setState(() {
    });
  }
}
