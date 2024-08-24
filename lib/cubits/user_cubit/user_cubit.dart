import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_api_app/models/user_model.dart';
import 'package:test_api_app/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserInitialState());
  final UserRepository userRepository;

  // sign in form key
  GlobalKey<FormState> signInFormKey = GlobalKey();

  // sign in email
  TextEditingController signInEmail = TextEditingController();

  // sign in password
  TextEditingController signInPassword = TextEditingController();

  // sign up form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  //Profile pic
  XFile? profilePic;

  // sign up name
  TextEditingController signUpName = TextEditingController();

  //sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();

  // sign up email
  TextEditingController signUpEmail = TextEditingController();

  // sign up password
  TextEditingController signUpPassword = TextEditingController();

  // sign up confirm password
  TextEditingController signUpConfirmPassword = TextEditingController();

  signIn() async {
    emit(SignInLoadingState());
    final response = await userRepository.signIn(
        email: signInEmail.text, password: signInPassword.text);

    response.fold((errorMsg) => emit(SignInFailureState(errorMsg: errorMsg)),
        (signInModel) => emit(SignInSuccessState()));
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePicState());
  }

  signUp() async {
    emit(SignUpLoadingState());
    final response = await userRepository.signUp(
        name: signUpName.text,
        email: signUpEmail.text,
        phoneNumber: signUpPhoneNumber.text,
        password: signUpPassword.text,
        confimPassword: signUpConfirmPassword.text,
        profilePic: profilePic!);
    response.fold(
        (errorMsg) => emit(SignUpFailureState(errorMsg: errorMsg)),
        (signUpModel) =>
            emit(SignUpSuccessState(message: signUpModel.message)));
  }

  getUserProfile() async {
    emit(GetUserLoading());
    final response = await userRepository.getUserProfile();
    response.fold((errorMsg) => emit(GetUserFailure(errorMsg: errorMsg)),
        (userModel) => emit(GetUserSuccess(user: userModel)));
  }
}
