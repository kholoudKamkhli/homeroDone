import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homero/controllers/database/user_database.dart';

import '../../models/notifications_model.dart';

class NotificationDatabase{
  static CollectionReference<NotificationModel> getNotificationsCollection(String userId) {
    return UserDatabase.getUsersCollection()
        .doc(userId)
        .collection(NotificationModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            NotificationModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<List<NotificationModel>> getUserNotifications(String userId)async{
    final snapshot = await getNotificationsCollection(userId).get();
    List<NotificationModel>notifications =  snapshot.docs
        .map((doc) => doc.data()).toList();

    return notifications;
  }
  static addNotification(String userId,NotificationModel notification){
    var doc =  getNotificationsCollection(userId).doc().set(notification);
  }
}