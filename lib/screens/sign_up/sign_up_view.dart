import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/screens/otp/otp_verification.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controllers/view_models/auth_controllers/sign_up_controller/sign_up_view_model_bloc.dart';
import '../home_screen/home_screen_view.dart';
import '../sign_in/sign_in_view.dart';
class SignUpView extends StatefulWidget {
  static const String routeName = "SignUp";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpViewModelBloc signUpViewModel = SignUpViewModelBloc();
  var formKey = GlobalKey<FormState>();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var numberCont = TextEditingController();
  var nameCont = TextEditingController();
  var completeNum;
  bool validationError = false;
  bool valuefirst = false;
  bool valuesecond = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpViewModelBloc>(
      create: (_) => signUpViewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<SignUpViewModelBloc, SignUpState>(
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
                    "assets/images/img_24.png",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/img_23.png",
                            width: 37,
                            height: 64,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                           Text(
                            "Sign up",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 84, 84, 84),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 327,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black45)),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                 Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 3),
                                  child: Text(
                                    "Full Name",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 127, 131),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextFormField(
                                      controller: nameCont,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter valid name";
                                        } else {
                                          return null;
                                        }
                                      },
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      cursorHeight: 20,
                                      cursorWidth: 1,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 327,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black45)),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                 Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 3),
                                  child: Text(
                                    "Email",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 127, 131),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextFormField(
                                      cursorColor:
                                      Theme.of(context).primaryColor,
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
                                      cursorHeight: 20,
                                      cursorWidth: 1,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 327,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black45)),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                 Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 3,
                                  ),
                                  child: Text(
                                    "Password",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 126, 127, 131),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextFormField(
                                      cursorColor:
                                      Theme.of(context).primaryColor,
                                      controller: passwordCont,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password can't be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      cursorHeight: 20,
                                      cursorWidth: 1,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8, right: 5,left: 5),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 8),
                            width: 327,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 126, 127, 131)),
                            ),
                            child: IntlPhoneField(
                              cursorColor:
                              Theme.of(context).primaryColor,
                              controller: numberCont,
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: "Mobile num",
                                border: InputBorder.none,
                              ),
                              initialCountryCode: 'EG',
                              onChanged: (phone) {
                                completeNum = phone.completeNumber;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              validateForm();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: 327,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 18),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 18),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 52, 205, 196),
                                  borderRadius: BorderRadius.circular(10)),
                              child:  Text(
                                "Continue",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SignInView.routeName);
                            },
                            child:  Text(
                              "Sign in",
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 84, 84, 84)),
                            ),
                          ),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    const EdgeInsets.only(left: 35, top: 18,right:35),
                                child: Checkbox(
                                    value: valuesecond,
                                    //fillColor: MaterialStateProperty.resolveWith((states) => null),
                                    activeColor: Colors.transparent,
                                    checkColor:
                                        const Color.fromARGB(255, 84, 84, 84),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value != null) valuesecond = value;
                                      });
                                    }),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 18),
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  "By creating your account on Homero agree to the Terms of Uses, Conditions & Privacy Policies",
                                  style: TextStyle(
                                    color: validationError
                                        ? Colors.red
                                        : const Color.fromARGB(255, 84, 84, 84),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              Container(
                                width: 46,
                                height: 1,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 84, 84, 84),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                               Text(
                                  "Or sign in with",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 84, 84, 84)),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 46,
                                height: 1,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 84, 84, 84),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: IconButton(
                                    onPressed: () async {
                                      signUpViewModel.signInWithFacebookFun();
                                    },
                                    icon:
                                        Image.asset("assets/images/img_26.png")),
                              ),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: IconButton(
                                    onPressed: () async {
                                      signUpViewModel.signInWithGoogleFun();
                                    },
                                    icon:
                                        Image.asset("assets/images/img_28.png")),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          },
          listener: (context, state) {
            if (state is LoadedState) {
              Navigator.pushReplacementNamed(context, HomeScreenView.routeName);
            }
            if (state is CodeSentState) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => OTPVerificstion(
                      verificationId: state.verificationId,
                      mail: emailCont.text,
                      password: passwordCont.text,
                      phone: completeNum,
                      username: nameCont.text)));
            }
          },
        ),
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate() && valuesecond) {
      validationError = false;
      signUpViewModel.sinInWithPhone(completeNum);
    } else {
      validationError = true;
      setState(() {});
    }
  }
}
