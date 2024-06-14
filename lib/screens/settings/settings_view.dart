import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/view_models/settings/settings_provider.dart';
import '../home_screen/home_screen_view.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var isSwitched = true;
  var isSwitched2 = false;
  int _selectedValue = 1;
  SharedPreferences? prefs;

  initPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return prefs == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomeScreenView.routeName),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Theme",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/img_37.png",
                        color: prefs?.getBool("isSwitched") ?? isSwitched
                            ? const Color.fromARGB(255, 52, 205, 196)
                            : const Color.fromARGB(255, 84, 84, 84),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Light",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                      Switch(
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            isSwitched2 = !value;
                            settingsProvider.changeTheme(
                              value ? ThemeMode.light : ThemeMode.dark,
                            );
                            prefs?.setBool("isSwitched", value);
                            prefs?.setBool("isSwitched2", !value);
                          });
                        },
                        value: prefs?.getBool("isSwitched") ?? isSwitched,
                        activeColor: Colors.white,
                        activeTrackColor: const Color.fromARGB(255, 52, 205, 196),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.black12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/img_37.png",
                        color: prefs?.getBool("isSwitched2") ?? isSwitched2
                            ? const Color.fromARGB(255, 52, 205, 196)
                            : const Color.fromARGB(255, 84, 84, 84),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Dark",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                      Switch(
                        onChanged: (value) {
                          setState(() {
                            isSwitched2 = value;
                            isSwitched = !value;
                            settingsProvider.changeTheme(
                              value ? ThemeMode.dark : ThemeMode.light,
                            );
                            prefs?.setBool("isSwitched2", value);
                            prefs?.setBool("isSwitched", !value);
                          });
                        },
                        value: prefs?.getBool("isSwitched2") ?? isSwitched2,
                        activeColor: Colors.white,
                        activeTrackColor: const Color.fromARGB(255, 52, 205, 196),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.black12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Language",
                style: const TextStyle(
                  color: Color.fromARGB(255, 84, 84, 84),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Theme(
              data: ThemeData(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedValue = 1;
                        prefs?.setInt("_selectedValue", _selectedValue);
                        settingsProvider.changeLocale("en");
                      });
                    },
                    child: RadioListTile(
                      title: Text(
                        "English",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      value: 1,
                      groupValue: prefs?.getInt("_selectedValue") ?? _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          if (value != null) {
                            _selectedValue = value;
                            prefs?.setInt("_selectedValue", value);
                            settingsProvider.changeLocale("en");
                          }
                        });
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedValue = 2;
                        prefs?.setInt("_selectedValue", _selectedValue);
                        settingsProvider.changeLocale("ar");
                      });
                    },
                    child: RadioListTile(
                      title: Text(
                        "Arabic",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      value: 2,
                      groupValue: prefs?.getInt("_selectedValue") ?? _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          if (value != null) {
                            _selectedValue = value;
                            prefs?.setInt("_selectedValue", value);
                            settingsProvider.changeLocale("ar");
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
