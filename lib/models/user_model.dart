import 'package:test_api_app/core/api/end_points.dart';

class UserModel{
  final String profilePic;
  final String name;
  final String email;
  final String phone;
  final Map<String,dynamic> location;

  UserModel({required this.profilePic, required this.name, required this.email, required this.phone,required this.location});
  
  factory UserModel.fromJson(Map<String,dynamic> jsonData){
    return UserModel(
    location: jsonData["user"][ApiKey.location], 
    profilePic: jsonData["user"][ApiKey.profilePic], 
    name: jsonData["user"][ApiKey.name], 
    email: jsonData["user"][ApiKey.email],
    phone: jsonData["user"][ApiKey.phone]);
  }

}