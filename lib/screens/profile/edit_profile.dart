import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/profile/profile_view.dart';

import '../../controllers/database/user_database.dart';
import '../../controllers/view_models/profile_view_model.dart';
import '../shared/dialog_utils.dart';
class EditProfile extends StatefulWidget {
  static const String routeName = "editProfile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var image;
  var usernameCont = TextEditingController();
  var mailCont = TextEditingController();
  var phoneNumCont = TextEditingController();
  var passwordCont = TextEditingController();
  var locationCont = TextEditingController();
  MyUser? user;
  FocusNode usernameFocus = FocusNode();
  FocusNode mailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode locationFocus = FocusNode();
  var formKey = GlobalKey<FormState>();
  var color = Colors.transparent;
  var hintColor = Colors.white;
  ProfileViewModel viewModel = ProfileViewModel();
  bool enabled = true;
  bool isClicked = false;

  Future<void> initUser() async {
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    if (user!.imageUrl == "") {
      image = const AssetImage("assets/images/img_10.png");
    } else {
      image = NetworkImage(user!.imageUrl);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
    usernameFocus.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Edit profile",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileView(), maintainState: true),
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          viewModel.getImage(user!);
                          isClicked = true;print(isClicked);
                          setState(() {

                          });
                        },
                        child: BlocProvider<ProfileViewModel>(
                          create: (_) => viewModel,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              isClicked
                                  ? BlocBuilder<ProfileViewModel, ProfileState>(
                                      builder: (context, state) {
                                      if (state is LoadedState) {
                                        isClicked = false;
                                        return CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              NetworkImage(state.image),
                                        );
                                      }
                                      else if(state is ErrorState){
                                        return CircleAvatar(
                                          radius: 50,
                                          child: Center(child: Text(state.errorMessage),),
                                        );
                                      }
                                      else{
                                        return const CircleAvatar(
                                          radius: 50,
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: image,
                                    ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    "assets/images/img_33.png",
                                    height: 32,
                                    width: 32,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Click to edit",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onTap: () {},
                        onEditingComplete: () {
                          if (usernameCont.text != null &&
                              usernameCont.text != "") {
                            user!.username = usernameCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },
                        controller: usernameCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid name";
                          } else {
                            return null;
                          }
                        },
                        focusNode: usernameFocus,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.person_outline_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.username,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          // hint: user!.username,
                          labelStyle: TextStyle(
                              color: usernameFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: usernameFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: usernameFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (mailCont.text != null && mailCont.text != "") {
                            user!.email = mailCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },
                        controller: mailCont,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return null;
                          } else {
                            return "Please enter valid Email";
                          }
                        },
                        focusNode: mailFocus,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.email_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.email,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          //labelText: "Email",
                          labelStyle: TextStyle(
                              color: mailFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: mailFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: mailFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (phoneNumCont.text != null &&
                              phoneNumCont.text != "") {
                            user!.phoneNum = phoneNumCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },
                        controller: phoneNumCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter phone number";
                          } else {
                            return null;
                          }
                        },
                        focusNode: phoneFocus,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.phone_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.phoneNum ?? "Phone Number",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          //labelText: "Phone Number",
                          labelStyle: TextStyle(
                              color: phoneFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: phoneFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: phoneFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: user!.email);
                          MyDialogUtils.showAnotherMessage(
                              context,
                              "Activation message has been sent to your mail",
                              "Ok");
                        } catch (e) {}
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 44,
                        width: 344,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Text(
                                "..........",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (locationCont.text != null &&
                              locationCont.text != "") {
                            user!.address = locationCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },
                        controller: locationCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid location";
                          } else {
                            return null;
                          }
                        },
                        focusNode: locationFocus,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.address ?? "location",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          //labelText: "Location",
                          labelStyle: TextStyle(
                              color: locationFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: locationFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: locationFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
