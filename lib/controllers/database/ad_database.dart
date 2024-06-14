import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/ad_model.dart';
import '../../models/service_model.dart';


class AdDatabase {
  static CollectionReference<AdModel> getAdsCollection() {
    return FirebaseFirestore.instance.collection(AdModel.COLLECTION_NAME).withConverter(
        fromFirestore: (snapshot, options) => AdModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }

  static Future<List<AdModel>> getAds() async {
    QuerySnapshot<AdModel> querySnapshot = await getAdsCollection().get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
  static CollectionReference<SubServiceModel> getSubServiceCollection(String adId) {
    return getAdsCollection()
        .doc(adId)
        .collection(SubServiceModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            SubServiceModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<SubServiceModel> getAdSubServices(String adId)async{
    final snapshot = await getSubServiceCollection(adId).get();
    List<SubServiceModel>subServices =  snapshot.docs
        .map((doc) => doc.data()).toList();
    return subServices[0];
  }
}
