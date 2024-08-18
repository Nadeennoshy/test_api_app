part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitialState extends UserState {}
final class SignInLoadingState extends UserState {}
final class SignInSuccessState extends UserState {}
final class SignInFailureState extends UserState {
  final String errorMsg;

  SignInFailureState({required this.errorMsg});
  
}

final class UploadProfilePicState extends UserState {}

final class SignUpLoadingState extends UserState {}
final class SignUpSuccessState extends UserState {
  final String message;

  SignUpSuccessState({required this.message});
}
final class SignUpFailureState extends UserState {
  final String errorMsg;

  SignUpFailureState({required this.errorMsg});
}  