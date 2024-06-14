import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/sign_up/sign_up_view.dart';
import '../../controllers/view_models/auth_controllers/sign_in_controller/sign_in_view_model_bloc.dart';

class SignInView extends StatefulWidget {
  static const String routeName = "SignIn";

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // late dynamic viewModel;
  FocusNode passwordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  var formKey = GlobalKey<FormState>();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var color = Colors.transparent;
  var hintColor = Colors.white;
  var color2 = Colors.transparent;
  var hintColor2 = Colors.white;
  bool enabled = true;
  SignInViewModelBloc signInViewModel = SignInViewModelBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        setState(() {
          passwordFocus.unfocus();
          color2 = Colors.white;
          hintColor2 = Colors.grey;
          hintColor = Colors.white;
          color = Colors.transparent;
        });
      } else {
        setState(() {
          color2 = Colors.transparent;
          hintColor2 = Colors.white;
        });
      }
    });

    passwordFocus.addListener(() {
      if (passwordFocus.hasFocus) {
        setState(() {
          emailFocus.unfocus();
          hintColor = Colors.grey;
          color = Colors.white;
        });
      } else {
        setState(() {
          hintColor = Colors.white;
          color = Colors.transparent;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInViewModelBloc>(
      create: (_) => signInViewModel,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<SignInViewModelBloc, SignInState>(
            builder: (context, state) {
              if (state is ErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/img_17.png",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/img_18.png"),
                          const SizedBox(
                            height: 50,
                          ),
                           Text(
                            "Welcome Back",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Text(
                            "Sign in",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 18),
                                    child: TextFormField(
                                      controller: emailCont,
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
                                      focusNode: emailFocus,
                                      decoration: InputDecoration(
                                        focusColor: Colors.white,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                          color: hintColor2,
                                        ),
                                        filled: true,
                                        enabled: enabled,
                                        fillColor: color2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 18),
                                    child: TextFormField(
                                      controller: passwordCont,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter valid Password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      focusNode: passwordFocus,
                                      decoration: InputDecoration(
                                        focusColor: Colors.white,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: hintColor,
                                        ),
                                        filled: true,
                                        enabled: enabled,
                                        fillColor: color,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      validateForm();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 60,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 18),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 18),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:  Text(
                                        "Sign in",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 52, 205, 196),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 40),
                                      Container(
                                        width: 46,
                                        height: 1,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                       Text(
                                        "Or sign with",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 46,
                                        height: 1,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: IconButton(
                                            onPressed: () async {
                                              signInViewModel
                                                  .signInWithFacebookFun();
                                            },
                                            icon: Image.asset(
                                                "assets/images/img_19.png")),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: IconButton(
                                          iconSize: 15,
                                            onPressed: () async {
                                              signInViewModel
                                                  .signInWithGoogleFun();
                                            },
                                            icon: Image.asset(
                                                "assets/images/img_21.png")),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                   Text(
                                    "Don't have an account",
                                    style:const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SignUpView.routeName);
                                    },
                                    child:  Text(
                                      "Sign up",
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                );
              }
            },
            listener: (context, state) {
              if (state is LoadedState) {
                Navigator.pushReplacementNamed(
                    context, HomeScreenView.routeName);
              }
            },
          )),
    );
  }

  void validateForm() async {
    if (formKey.currentState!.validate()) {
      signInViewModel.signInWithEmailAndPassword(
          emailCont.text, passwordCont.text, context);
    }
  }
}
