import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/reccomendation_model.dart';
import '../database/recommendation_database.dart';

class RecommendationViewModel extends Cubit<RecommendsState>{
  RecommendationViewModel():super(RecommendsLoadingState());
  initRecommends()async{
    try{
      emit(RecommendsLoadingState());
      List<RecommendationModel>recommends = await RecommendationDatabase.getRecommends();
      emit(RecommendsLoadedState(recommends));
    }catch(e){
      emit(ErrorRecommendsState(e.toString()));
    }
  }
}
abstract class RecommendsState{}
class RecommendsLoadingState extends RecommendsState{}
class ErrorRecommendsState extends RecommendsState{
  String message;
  ErrorRecommendsState(this.message);
}

class RecommendsLoadedState extends RecommendsState{
  List<RecommendationModel>recommends;
  RecommendsLoadedState(this.recommends);
}