import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ad_model.dart';
import '../database/ad_database.dart';

class AdsViewModel extends Cubit<AdsState>{
  AdsViewModel():super(LoadingAdsState());
  Future<bool?> initAds()async{
    try{
      emit(LoadingAdsState());
      List<AdModel>ads = await AdDatabase.getAds();
      emit(AdsloadedState(ads));
      print("äds loaded state");
      return true;
    }catch(e){
      emit(AdsErrorState(e.toString()));
    }
  }
}
abstract class AdsState{}
class LoadingAdsState extends AdsState{}
class AdsErrorState extends AdsState{
  String errorMessage;
  AdsErrorState(this.errorMessage);
}
class AdsloadedState extends AdsState{
  List<AdModel>ads;
  AdsloadedState(this.ads);
}