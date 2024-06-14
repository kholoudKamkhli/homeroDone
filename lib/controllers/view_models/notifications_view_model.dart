import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/controllers/database/notification_database.dart';
import 'package:homero/controllers/view_models/auth_controllers/sign_in_controller/sign_in_view_model_bloc.dart';

import '../../models/notifications_model.dart';

class NotificationsViewModel extends Cubit<NotificationState>{
  NotificationsViewModel():super(LoadingNotifications());
  getUserNotifications()async{
    try{
      emit(LoadingNotifications());
      List<NotificationModel>notifications = await NotificationDatabase.getUserNotifications(FirebaseAuth.instance.currentUser!.uid);
      emit(LoadedNotifications(notifications));
    }catch(e){
      emit(ErrorNotifications(e.toString()));
    }
  }
}
abstract class NotificationState{}
class LoadingNotifications extends NotificationState{}
class LoadedNotifications extends NotificationState{
  List<NotificationModel> notifications;
  LoadedNotifications(this.notifications);
}
class ErrorNotifications extends NotificationState{
  String errorMessage;
  ErrorNotifications(this.errorMessage);
}