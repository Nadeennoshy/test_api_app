class EndPoint{
  static String baseUrl = 'https://food-api-omega.vercel.app/api/v1/';
  static String signIn = 'user/signin';
  static String signUp = 'user/signup';
  static String checkEmail = 'user/check-email';
  static String updateUser = 'user/update';
  static String logOut = 'user/logout';
  static String getUserData(id){
    return "user/get-user/$id";
  }
}

class ApiKey{
  static String status = 'status';
  static String errorMessage = 'ErrorMessage';
  static String email = "email";
  static String password = "password";
  static String message = "message";
  static String name = "name";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String token = "token";
  static String id = "id";
  static String profilePic = "profilePic";
}