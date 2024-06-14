import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/notifications/notification_view.dart';
import 'package:homero/screens/orders/orders_view.dart';
import 'package:homero/screens/profile/profile_view.dart';
import 'package:homero/screens/services/services_view.dart';
import 'package:homero/screens/settings/settings_view.dart';
import '../../controllers/database/user_database.dart';
import '../home_tab_screen/home_tab.dart';
class HomeScreenView extends StatefulWidget {
  static const String routeName = "homeScreen";

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int selectedIndex = 2;
  MyUser? user;
  var image;

  initUser() async {
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    if(user!.imageUrl==""){
      image = const AssetImage("assets/images/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg");
    }
    else{
      image = NetworkImage(user!.imageUrl);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: selectedIndex == 2
                ? AppBar(
                    elevation: 0,
                    title: Image.asset(
                      "assets/images/img.png",
                      width: 83,
                      height: 21,
                    ),
                    centerTitle: false,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, NotificationView.routeName);
                        },
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 50,
                          backgroundImage: image,
                        ),
                        color: const Color.fromARGB(255, 52, 205, 196),
                        onPressed: () {
                          Navigator.pushNamed(context, ProfileView.routeName);
                        },
                      ),
                    ],
              automaticallyImplyLeading: false,
                  )
                : null,
            bottomNavigationBar: BottomNavigationBar(
                //selectedItemColor: const Color.fromARGB(255, 52, 205, 196),
                type: BottomNavigationBarType.fixed,
                //backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                onTap: (selected) {
                  setState(() {
                    selectedIndex = selected;
                  });
                },
                currentIndex: selectedIndex,
                items:  [
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                    icon: const ImageIcon(AssetImage("assets/images/img_13.png")),
                    label: "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: const ImageIcon(AssetImage("assets/images/img_14.png")),
                    label: "Orders",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: const ImageIcon(AssetImage("assets/images/img_15.png")),
                    label: "Services",
                  ),
                  BottomNavigationBarItem(
                    icon: const ImageIcon(AssetImage("assets/images/img_16.png")),
                    label: "Settings",
                  ),
                ]),
            body: tabs[selectedIndex],
          );
  }

  List<Widget> tabs = [
    ProfileView(),
    OrdersView(),
    HomeTab(),
    ServicesView(),
    SettingsView()
  ];
  List<String> names = ["Profile", "Orders", "", "Services", "Settings"];
}
