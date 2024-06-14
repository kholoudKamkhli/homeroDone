import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../models/user_model.dart';
import '../../../database/user_database.dart';
class SignInViewModelBloc extends Cubit<SignInState> {
  SignInViewModelBloc() : super(LoadingState());

  signInWithFacebookFun() async {
    emit(LoadingState());
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Sign in with Facebook credentials
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

        // Check if the user is new and add to the database if necessary
        if (!await UserDatabase.check(userCredential.user?.uid ?? "")) {
          MyUser user = MyUser(
              id: userCredential.user?.uid ?? "",
              username: userCredential.user?.displayName ?? "",
              email: userCredential.user?.email ?? "",
              phoneNum: userCredential.user?.phoneNumber ?? "",
              imageUrl: userCredential.user?.photoURL ?? ""
          );
          UserDatabase.addUserToDatabase(user);
        }

        // Emit success state
        emit(LoadedState());
      } else if (loginResult.status == LoginStatus.cancelled) {
        emit(ErrorState('Facebook login cancelled.'));
      } else {
        emit(ErrorState('Facebook login failed: ${loginResult.message}'));
      }
    } catch (e) {
      emit(ErrorState('An error occurred: ${e.toString()}'));
    }
  }


  signInWithGoogleFun() async {
    emit(LoadingState());
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        throw Exception('Google sign-in canceled.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with the credential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if user exists in the database, if not, add the user
      if (!await UserDatabase.check(userCredential.user?.uid ?? "")) {
        MyUser user = MyUser(
            id: userCredential.user?.uid ?? "",
            username: userCredential.user?.displayName ?? "",
            email: userCredential.user?.email ?? "",
            phoneNum: userCredential.user?.phoneNumber ?? "",
            imageUrl: userCredential.user?.photoURL ?? ""
        );
        UserDatabase.addUserToDatabase(user);
      }

      // Emit success state if the Bloc is not closed
      if (!isClosed) emit(LoadedState());
    } catch (e) {
      // Emit error state if the Bloc is not closed
      if (!isClosed) emit(ErrorState('An error occurred during Google sign-in: ${e.toString()}'));
    }
  }

  signInWithEmailAndPassword(String mail,String password,BuildContext context)async {
    try {
      emit(LoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: password
      );
      //MyUser? user = await UserDatabase.getUser(credential.user?.uid ?? "");
      emit(LoadedState());
      return;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ErrorState("User Not Found"));
      } else if (e.code == 'wrong-password') {
        emit(ErrorState('Wrong password provided for that user.'));
      }
    }
  }
}

abstract class SignInState {}

class LoadingState extends SignInState {}

class ErrorState extends SignInState {
  String errorMessage;
  ErrorState(this.errorMessage);
}

class LoadedState extends SignInState {}
