import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/notifications/notification_view.dart';
import 'package:homero/screens/orders/orders_view.dart';
import 'package:homero/screens/package/selected_package_screen.dart';
import 'package:homero/screens/profile/edit_profile.dart';
import 'package:homero/screens/profile/payment_history.dart';
import 'package:homero/screens/profile/profile_view.dart';
import 'package:homero/screens/profile/scheduled_view.dart';
import 'package:homero/screens/service_details/service_details_view.dart';
import 'package:homero/screens/services/selected_service_view.dart';
import 'package:homero/screens/services/services_view.dart';
import 'package:homero/screens/shared/theme.dart';
import 'package:homero/screens/sign_in/sign_in_view.dart';
import 'package:homero/screens/sign_up/sign_up_view.dart';
import 'package:homero/screens/spalsh_screens/splash_screen1.dart';
import 'package:homero/screens/workers/worker_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/view_models/settings/settings_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  //addServices(mainServices,supServices);
  // Stripe.publishableKey =
  //     "pk_test_51Mg3P2Lfuo7YOusxbCq7QqHZmV7c8JaTHeEXKSVG7F7wAhKO86GaZF3BagsybszMEXrp3pDoFGan25JPsPvoOOau00WNmCStr1";
  await dotenv.load(fileName: "assets/.env");
  runApp(ChangeNotifierProvider(
    create: (buildContext)=>SettingsProvider(isDarkMode: prefs.getBool("isDarkMode"),isArabic:prefs.getBool("isArabic")),
      child: MyApp()));
  print("isDarkMode Value ${prefs.getBool("isDarkMode")}");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context,settingsProvider,child){
      return MaterialApp(
        locale: Locale(settingsProvider.currentLang),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('ar'), //arabic
        ],
        routes: {
          SplashScreenOne.routeName: (_) => SplashScreenOne(),
          HomeScreenView.routeName: (_) => HomeScreenView(),
          SignInView.routeName: (_) => SignInView(),
          SignUpView.routeName: (_) => SignUpView(),
          EditProfile.routeName: (_) => EditProfile(),
          WorkerView.routeName: (_) => WorkerView(),
          //PaymentView.routeName: (_) => PaymentView(),
          ServiceDetailsView.routeName: (_) => ServiceDetailsView(),
          ServicesView.routeName:(_)=>ServicesView(),
          //MapScreen.routeName:(_)=>MapScreen(),
          OrdersView.routeName:(_)=>OrdersView(),
          ScheduledOrdersView.routeName:(_)=>ScheduledOrdersView(),
          SelectedServiceView.routeName:(_)=>SelectedServiceView(),
          PaymentHistory.routeName:(_)=>PaymentHistory(),
          ProfileView.routeName:(_)=>ProfileView(),
          SelectedPackageView.routeName:(_)=>SelectedPackageView(),
          NotificationView.routeName:(_)=>NotificationView(),
        },
        initialRoute: FirebaseAuth.instance.currentUser!=null?HomeScreenView.routeName:SplashScreenOne.routeName,
        //initialRoute: SignInView.routeName,
        //initialRoute: SignInView.routeName,
        theme:MyTheme.lightTheme ,
        darkTheme: MyTheme.darkTheme,
        themeMode: settingsProvider.getTheme(),
      );
    });

  }
}
