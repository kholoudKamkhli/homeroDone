import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/controllers/database/package_database.dart';
import 'package:homero/models/package_model.dart';
import 'package:homero/models/service_model.dart';

class PackageViewModel extends Cubit<PackageState>{
  PackageViewModel():super(LoadingPackageState());
  getPackages()async{
    try{
      emit(LoadingPackageState());
      List<PackageModel>packages = await PackageDatabase.getPackages();
      emit(LoadedPackagesState(packages));
    }catch(e){
      emit(ErrorPackagesState(e.toString()));
    }
  }
  getPackageSubServices(String id)async{
    try{
      emit(LoadingPackageState());
      List<SubServiceModel>subServices = await PackageDatabase.getPackageSubServices(id);
      emit(LoadedPackageServicesState(subServices));
    }catch(e){
      emit(ErrorPackagesState(e.toString()));
    }

  }
}
abstract class PackageState {}
class LoadingPackageState extends PackageState{}
class LoadedPackagesState extends PackageState{
  List<PackageModel>packages;
  LoadedPackagesState(this.packages);
}
class LoadedPackageServicesState extends PackageState{
  List<SubServiceModel>subServices;
  LoadedPackageServicesState(this.subServices);
}
class ErrorPackagesState extends PackageState{
  String errorMessage;
  ErrorPackagesState(this.errorMessage);
}