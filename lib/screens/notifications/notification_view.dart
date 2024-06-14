import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/controllers/view_models/notifications_view_model.dart';
import 'package:homero/screens/notifications/notification_widget.dart';

class NotificationView extends StatefulWidget {
  static const String routeName = "NotificationView";

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  NotificationsViewModel notificationsViewModel = NotificationsViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationsViewModel.getUserNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider<NotificationsViewModel>(
          create: (_) => notificationsViewModel,
          child: BlocBuilder<NotificationsViewModel, NotificationState>(
            builder: (context, state) {
              if (state is ErrorNotifications) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is LoadedNotifications) {
                return ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return NotificationWidget(notification:state.notifications[index]);
                  },
                  itemCount: state.notifications.length,
                );
              }
              else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          )),
    );
  }
}
