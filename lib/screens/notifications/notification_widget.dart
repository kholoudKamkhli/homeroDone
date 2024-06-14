import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/models/notifications_model.dart';
import 'package:intl/intl.dart';

import '../../controllers/database/user_database.dart';
import '../../models/user_model.dart';

class NotificationWidget extends StatefulWidget {
  NotificationModel notification;
  NotificationWidget({required this.notification});
  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  MyUser ?user;
  var image;
  Future<void> initUser() async {
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    if (user!.imageUrl == "") {
      image = const AssetImage(
          "assets/images/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg");
    } else {
      image = NetworkImage(user!.imageUrl);
    }
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }
  @override
  Widget build(BuildContext context) {
    return user==null?const Center(child: CircularProgressIndicator(),):Card(
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(

              children: [
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: image,
                  ),
                ),
                const SizedBox(width: 10,),
                 SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                    child: Text(widget.notification.content,style: Theme.of(context).textTheme.bodyMedium,)),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.bottomRight,
              child: (Text(DateFormat.yMMMEd().format(widget.notification.date),style: Theme.of(context).textTheme.bodySmall,)),
            )
          ],
        ),
      ),
    );
  }
}
