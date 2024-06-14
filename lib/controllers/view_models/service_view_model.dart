import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/service_model.dart';
import '../database/service_database.dart';
class HomeViewModel extends Cubit<HomeState>{
  List<ServiceModel>servicesList = [];
  HomeViewModel():super(LoadingState());

  initServices()async{
    try{
      emit(ServicesLoadingState());
      List<ServiceModel>services = await ServiceDatabase.getMainServices();
      emit(ServicesloadedState(services));
      servicesList = services;
    }catch(e){
      emit(ServicesErrorState(e.toString()));
    }
  }

}
class ServiceViewModel extends Cubit<ServiceState>{
  ServiceViewModel():super(LoadingServiceState());
  initServicesNames()async{
    try{
      emit(LoadingServiceState());
      List<ServiceModel>services = await ServiceDatabase.getMainServices();
      emit(LoadedServiceState(services));
    }catch(e){
      emit(ErrorLoadingService(e.toString()));
    }
  }

}
abstract class ServiceState{}
class LoadingServiceState extends ServiceState{}
class LoadedServiceState extends ServiceState{
  List<ServiceModel>services;
  LoadedServiceState(this.services);
}
class ErrorLoadingService extends ServiceState{
  String errorMessage;
  ErrorLoadingService(this.errorMessage);
}
abstract class HomeState{}

class LoadingState extends HomeState{}
class ServicesErrorState extends HomeState{
  String errorMessage;
  ServicesErrorState(this.errorMessage);
}
class ServicesloadedState extends HomeState{
  List<ServiceModel>services;
  ServicesloadedState(this.services);
}
class ServicesLoadingState extends HomeState{}



