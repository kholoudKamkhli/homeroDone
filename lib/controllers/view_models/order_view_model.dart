import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order_model.dart';
import '../database/order_database.dart';

class OrderViewModel extends Cubit<OrderState>{
  List<OrderModel> orders = [];
  OrderViewModel():super(LoadingState());
  initOrders(int index) async {
    try{
      emit(LoadingState());
      if(index==0){
        orders = await OrderDatabase.getuserAllOrders(
            FirebaseAuth.instance.currentUser!.uid);
      }
      else if (index == 1) {
        orders = await OrderDatabase.getuserScheduledOrders(
            FirebaseAuth.instance.currentUser!.uid);
      } else {
        orders = await OrderDatabase.getuserFinishedOrders(
            FirebaseAuth.instance.currentUser!.uid);
      }
      emit(LoadedState(orders: orders));
    }catch(e){
      emit(ErrorState(errorMessage:e.toString()));
    }

  }
  getScheduledOrders()async{
    List<OrderModel>orders;
    try{
      emit(LoadingState());
      orders = await OrderDatabase.getuserScheduledOrders(FirebaseAuth.instance.currentUser!.uid);
      emit(LoadedState(orders: orders));
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
  getAllOrders()async{
    List<OrderModel>orders;
    try{
      emit(LoadingState());
      orders = await OrderDatabase.getuserAllOrders(FirebaseAuth.instance.currentUser!.uid);
      emit(LoadedState(orders: orders));
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

}
abstract class OrderState{}
class LoadingState extends OrderState{}
class ErrorState extends OrderState{
  String errorMessage;
  ErrorState({required this.errorMessage});
}
class LoadedState extends OrderState{
  List<OrderModel> orders;
  LoadedState({required this.orders});
}
