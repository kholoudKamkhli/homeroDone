
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/worker_model.dart';
import '../database/worker_database.dart';

class WorkerViewModel extends Cubit<WorkerSate>{
  WorkerViewModel():super(LoadingState());
  initWorkers(String serviceName)async{
    try{
        emit(LoadingState());
        List<WorkerModel> workers = await WorkerDatabase.getWorkers(serviceName);
        emit(LoadedState(workers: workers));
      }
    catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

}
abstract class WorkerSate{}
class LoadingState extends WorkerSate{}
class ErrorState extends WorkerSate{
  String errorMessage;
  ErrorState({required this.errorMessage});
}
class LoadedState extends WorkerSate{
  List<WorkerModel>workers;
  LoadedState({required this.workers});
}
