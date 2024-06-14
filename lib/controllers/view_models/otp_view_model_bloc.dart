import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../database/user_database.dart';

class OTPViewModelBloc extends Cubit<OTPState>{
  OTPViewModelBloc():super(LoadingOTP());
  static FirebaseAuth auth = FirebaseAuth.instance;
   authenticate(String verificationId,String completeCode,String mail,String password,String username,String phone)async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: completeCode);
    await auth.signInWithCredential(credential);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      MyUser user = MyUser(id: credential.user?.uid??"", username: username, email: mail,phoneNum:phone );
      UserDatabase.addUserToDatabase(user);
      //navigate to homeScreen here
      emit(DoneOTP());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(ErrorOTP("Password is weak "));
      } else if (e.code == 'email-already-in-use') {
        emit(ErrorOTP("email-already-in-use"));
      }
    } catch (e) {
      emit(ErrorOTP(e.toString()));
    }
  }
}
abstract class OTPState{}
class LoadingOTP extends OTPState{}
class ErrorOTP extends OTPState{
  String errorMessage;
  ErrorOTP(this.errorMessage);
}
class DoneOTP extends OTPState{}

