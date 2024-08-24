import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:test_api_app/cache/cache_helper.dart';
import 'package:test_api_app/core/api/api_consumer.dart';
import 'package:test_api_app/core/api/end_points.dart';
import 'package:test_api_app/core/errors/exceptions.dart';
import 'package:test_api_app/core/functions/upload_image_to_api.dart';
import 'package:test_api_app/models/sign_in_model.dart';
import 'package:dartz/dartz.dart';
import 'package:test_api_app/models/sign_up_model.dart';
import 'package:test_api_app/models/user_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<String, SignInModel>> signIn(
      {required String email, required String password}) async {
    try {
      final response = await api.post(EndPoint.signIn, data: {
        ApiKey.email: email,
        ApiKey.password: password,
      });
      final user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      CacheHelper().saveData(key: ApiKey.token, value: user.token);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String confimPassword,
    required XFile profilePic,
  }) async {
    try {
      final response = await api.post(
        EndPoint.signUp,
        isFormData: true,
        data: {
          ApiKey.name: name,
          ApiKey.email: email,
          ApiKey.phone: phoneNumber,
          ApiKey.password: password,
          ApiKey.confirmPassword: confimPassword,
          ApiKey.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKey.profilePic: await uploadImageToAPI(profilePic),
        },
      );
      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
          EndPoint.getUserDataEndPoint(CacheHelper().getData(key: ApiKey.id)));
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
