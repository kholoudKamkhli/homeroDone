import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/package_model.dart';
import '../../models/service_model.dart';

class PackageDatabase{
  static CollectionReference<PackageModel> getPackagesCollection() {
    return FirebaseFirestore.instance.collection(PackageModel.COLLECTION_NAME).withConverter(
        fromFirestore: (snapshot, options) => PackageModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<List<PackageModel>> getPackages() async {
    QuerySnapshot<PackageModel> querySnapshot =
    await getPackagesCollection().get();
    print(querySnapshot.docs.length);
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
  static CollectionReference<SubServiceModel> getSubServiceCollection(String packageId) {
    return getPackagesCollection()
        .doc(packageId)
        .collection(SubServiceModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            SubServiceModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<List<SubServiceModel>> getPackageSubServices(String id)async{

    final snapshot = await getSubServiceCollection(id).get();
    List<SubServiceModel>subServices =  snapshot.docs
        .map((doc) => doc.data()).toList();
    return subServices;
  }
}