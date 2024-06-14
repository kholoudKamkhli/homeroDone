
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/reccomendation_model.dart';
import '../../models/service_model.dart';
import '../../models/worker_model.dart';

class RecommendationDatabase {
  static CollectionReference<RecommendationModel> getRecommendationsCollection() {
    return FirebaseFirestore.instance
        .collection(RecommendationModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            RecommendationModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<List<RecommendationModel>> getRecommends() async {
    QuerySnapshot<RecommendationModel> querySnapshot =
    await getRecommendationsCollection().get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
  static Future<WorkerModel> getRecommendedWorker(String recommendationId) async {
    var snapshot = await getRecommendationsCollection()
        .doc(recommendationId)
        .collection("Wrokers")
        .withConverter(
      fromFirestore: (snapshot, options) =>
          WorkerModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .get();
    var workerDoc = snapshot.docs.first;
    var worker = workerDoc.data();
    print("Recommendation worker name ${worker.name}");
    return worker;
  }
  static Future<SubServiceModel> getRecommendedSubService(String recommendationId) async {
    var snapshot = await getRecommendationsCollection()
        .doc(recommendationId)
        .collection(SubServiceModel.COLLECTION_NAME)
        .withConverter(
      fromFirestore: (snapshot, options) =>
          SubServiceModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .get();
    var subServiceDoc = snapshot.docs.first;
    var service = subServiceDoc.data();
    print("Recommendation service name ${service.id}");
    return service;
  }
}
