
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class UserDatabase {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addUserToDatabase(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }
  static Future<bool> check(String id) async {
    if(id.isEmpty){return false;}
    var userRef = getUsersCollection().doc(id);
    var doc = await userRef.get();
    return doc.exists;
  }

  static updateImage(MyUser user, String imageUrl) {
    getUsersCollection().doc(user.id).update({'imageUrl': imageUrl});
  }

  static Future<MyUser?> getUser(String id) async {
    var user = await getUsersCollection().doc(id).get();
    var myUser = user.data();
    return myUser;
  }
  static editUser(MyUser user) async {
    var doc = await getUsersCollection().doc(user.id).set(user);
  }
}
