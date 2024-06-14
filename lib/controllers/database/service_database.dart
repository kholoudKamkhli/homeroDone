import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings/strings.dart';

import '../../models/service_model.dart';
class ServiceDatabase {
  static CollectionReference<ServiceModel> getServicesCollection() {
    return FirebaseFirestore.instance
        .collection(ServiceModel.COLLECTION_NAME)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                ServiceModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson());
  }
  static CollectionReference<SubServiceModel> getSubServiceCollection(String serviceId) {
    return getServicesCollection()
        .doc(serviceId)
        .collection(SubServiceModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            SubServiceModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }




  Future<List<ServiceModel>> getServices() async {
    QuerySnapshot<ServiceModel> querySnapshot =
        await getServicesCollection().get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
  static Future<List<ServiceModel>> getMainServices() async {
    final snapshot = await getServicesCollection().get();
    return snapshot.docs
        .map((doc) => doc.data()).toList();
  }
  static Future<List<ServiceModel>> getServiceById(String serviceId) async {
    final snapshot = await getServicesCollection().where('id', isEqualTo: serviceId).get();
    List<ServiceModel>ss =  snapshot.docs
        .map((doc) => doc.data()).toList();
    return ss;
  }

  static Future<SubServiceModel> getSubServiceByName(String name) async {
    List<ServiceModel> services = await getMainServices();
    List<SubServiceModel> subServices = [];
    for (int i = 0; i < services.length; i++) {
      subServices.addAll(await getServiceSubServices(services[i].id));
    }
    for(int i=0;i<subServices.length;i++){
      if(subServices[i].title==name) {
        print("recommended service name ${subServices[i].title}");
        return subServices[i];
      }
    }
    print("recommended 0 service name ${subServices[0].title}");
    return subServices[0];
  }
  static Future<List<SubServiceModel>> getAllSubServices(String searchString) async {
    searchString = (searchString);
    List<ServiceModel> services = await getMainServices();
    List<SubServiceModel> subServices = [];
    for (int i = 0; i < services.length; i++) {
      subServices.addAll(await getServiceSubServices(services[i].id));
    }
    List<SubServiceModel> filteredSubServices =
    subServices.where((subService) => subService.title.contains(searchString)).toList();
    return filteredSubServices;
  }
  static Future<List<SubServiceModel>> getServiceSubServices(String id)async{
    print('id inside getSubServices $id');

    final snapshot = await getSubServiceCollection(id).get();
    List<SubServiceModel>subServices =  snapshot.docs
        .map((doc) => doc.data()).toList();
    print("we are here");
    for(int i=0;i<subServices.length;i++){
      print("title one ${subServices[i].title}");
    }
    return subServices;
  }
  // static Future<List<ServiceModel>> searchServiceByTitle(String title) async {
  //   List<ServiceModel> searchResults = [];
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection(ServiceModel.COLLECTION_NAME)
  //       .where("title", isEqualTo: title)
  //       .get();
  //
  //   if (snapshot.docs.isNotEmpty) {
  //     snapshot.docs.forEach((doc) {
  //       final service = ServiceModel.fromJson(doc.data());
  //       service.id = doc.id;
  //       searchResults.add(service);
  //     });
  //   }
  //   print("Search result ${searchResults[0]}");
  //   return searchResults;
  // }
  static searchServiceByTitle2(String title)async{
    var snapshot = await getServicesCollection().get();
    List<dynamic> services = snapshot.docs
        .where((doc) => doc.data().title == title)
        .map((doc) => doc.data()).toList();
    print(services.length);
    return services;
  }
}
