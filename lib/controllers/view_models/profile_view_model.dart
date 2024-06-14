import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../database/user_database.dart';
class ProfileViewModel extends Cubit<ProfileState>{
  ProfileViewModel():super(LoadingState());
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future getImage(MyUser user) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    _image = image;
    print(_image?.path ?? "null path");
    if (_image != null) {
      emit(LoadingState());
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceImages = referenceRoot.child('images');
      Reference referenceImageToUpload = referenceImages.child(_image!.path);
      try {
        await referenceImageToUpload.putFile(File(_image!.path));
        String imageUrl = await referenceImageToUpload.getDownloadURL();
        user!.imageUrl = imageUrl;
        await UserDatabase.updateImage(user!, imageUrl);
        emit(LoadedState(user.imageUrl!));
        print("Loaded state in profile");
      } catch (error) {
        emit(ErrorState(error.toString()));
      }
    }
  }
}
abstract class ProfileState{}
class LoadingState extends ProfileState{}
class ErrorState extends ProfileState{
  String errorMessage;
  ErrorState(this.errorMessage);
}
class LoadedState extends ProfileState{
  var image;
  LoadedState(this.image);
}