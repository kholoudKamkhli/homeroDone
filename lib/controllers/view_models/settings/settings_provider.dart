import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingsProvider extends ChangeNotifier{
   ThemeMode selectedTheme = ThemeMode.light;
  late String currentLang ;
  SettingsProvider({ bool ?isDarkMode,bool ? isArabic}){
    if(isDarkMode==null){
      selectedTheme = ThemeMode.light;
    }
    else if(isDarkMode){
      selectedTheme = ThemeMode.dark;
    }
    else if(!isDarkMode){
      selectedTheme = ThemeMode.light;
    }
    if(isArabic==null){
      currentLang = "en";
    }
    else if(isArabic){
      currentLang = "ar";
    }
    else if(isArabic==false){
      currentLang = "en";
    }
  }
   
   changeTheme(ThemeMode newtheme)async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if(newtheme == ThemeMode.light){
       prefs.setBool("isDarkMode", false);
     }
     else{
       prefs.setBool("isDarkMode", true);
     }
    selectedTheme=newtheme;
     print("is Dark mode value is ${prefs.getBool("isDarkMode")}");
    notifyListeners();
  }

  isDarkTheme(){
     if(selectedTheme==ThemeMode.dark){
       return true;
     }
     else{
       return false;
     }
  }
   void changeLocale(String newLocale)async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if(newLocale == "ar"){
      prefs.setBool("isArabic", true);
    }
     else prefs.setBool("isArabic", false);
     currentLang = newLocale;
     notifyListeners();
   }
   bool isArabic(){
     return currentLang=='ar';
   }
   ThemeMode getTheme(){
     return selectedTheme;
   }
   String getLocale(){
    return currentLang;
   }
}