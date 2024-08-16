import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_api_app/core/api/api_consumer.dart';
import 'package:test_api_app/core/api/end_points.dart';
import 'package:test_api_app/core/errors/exceptions.dart';
import 'package:test_api_app/models/sign_in_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());

  final ApiConsumer api;
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
  SignInModel? user;
  signIn() async {
    try {
      emit(SignInLoading());
      final response = await api.post(EndPoint.signIn, data: {
        ApiKey.email: signInEmail.text,
        ApiKey.password: signInPassword.text,
      });
      user=SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user!.token);
      print(decodedToken['id']);
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errorMsg: e.errorModel.errorMessage));
    }
  }
}
