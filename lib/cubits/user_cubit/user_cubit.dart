import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_api_app/cache/cache_helper.dart';
import 'package:test_api_app/core/api/api_consumer.dart';
import 'package:test_api_app/core/api/end_points.dart';
import 'package:test_api_app/core/errors/exceptions.dart';
import 'package:test_api_app/core/functions/upload_image_to_api.dart';
import 'package:test_api_app/models/sign_in_model.dart';
import 'package:test_api_app/models/sign_up_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitialState());

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
      emit(SignInLoadingState());
      final response = await api.post(EndPoint.signIn, data: {
        ApiKey.email: signInEmail.text,
        ApiKey.password: signInPassword.text,
      });
      user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user!.token);
      CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      emit(SignInSuccessState());
    } on ServerException catch (e) {
      emit(SignInFailureState(errorMsg: e.errorModel.errorMessage));
    }
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePicState());
  }

  signUp() async {
    emit(SignUpLoadingState());
    try {
      final response = await api.post(EndPoint.signUp, isFormData: true, data: {
        ApiKey.name = signUpName.text,
        ApiKey.email = signUpEmail.text,
        ApiKey.phone = signUpPhoneNumber.text,
        ApiKey.password = signUpPassword.text,
        ApiKey.confirmPassword = signUpConfirmPassword.text,
        ApiKey.location =
            '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
        ApiKey.profilePic = await uploadImageToApi(profilePic!),
      });
      final signUpModel = SignInModel.fromJson(response);
      emit(SignUpSuccessState(message: signUpModel.message));
    } on ServerException catch (e) {
      emit(SignUpFailureState(errorMsg: e.errorModel.errorMessage));
    }
  }
}
