import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_api_app/core/api/api_consumer.dart';

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

  signIn() async{
    try {
      emit(SignInLoading());
      var response = await api.post('https://food-api-omega.vercel.app/api/v1/user/signin',data: {
        "email": signInEmail.text,
        "password": signInPassword.text,
      }
      
      //   'https://food-api-omega.vercel.app/api/v1/user/signin', data: {
      //   "email": signInEmail.text,
      //   "password": signInPassword.text,
      // }
      );
      emit(SignInSuccess());
      print(response);
      
    } catch (e) {
      emit(SignInFailure(errorMsg: e.toString()));
      print(e.toString());
    }
  }
}
