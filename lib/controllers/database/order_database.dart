import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homero/models/order_model.dart';

class OrderDatabase {
  static CollectionReference<OrderModel> getOrdersCollection() {
    return FirebaseFirestore.instance.collection(OrderModel.COLLECTION_NAME).withConverter(
        fromFirestore: (snapshot, options) => OrderModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addOrder(OrderModel order) {
    return getOrdersCollection().doc().set(order);
  }

  static Future<List<OrderModel>> getuserAllOrders(String userid) async {
    final snapshot = await getOrdersCollection().where("uId", isEqualTo: userid).get();
    List<OrderModel> orders = await snapshot.docs.map((doc) => doc.data()).toList();
    print(orders.length);
    return orders;
  }

  static Future<List<OrderModel>> getuserScheduledOrders(String userid) async {
    final snapshot = await getOrdersCollection().where("uId", isEqualTo: userid).get();
    List<OrderModel> orders = snapshot.docs.map((doc) => doc.data()).toList();
    List<OrderModel> scheduledOrders = [];
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].isScheduled) {
        scheduledOrders.add(orders[i]);
      }
    }
    print(scheduledOrders.length);
    return scheduledOrders;
  }

  static Future<List<OrderModel>> getuserFinishedOrders(String userid) async {
    final snapshot = await getOrdersCollection().where("uId", isEqualTo: userid).get();
    List<OrderModel> orders = snapshot.docs.map((doc) => doc.data()).toList();
    List<OrderModel> scheduledOrders = [];
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].isFinished) {
        scheduledOrders.add(orders[i]);
      }
    }

    print(scheduledOrders.length);
    return scheduledOrders;
  }
}
