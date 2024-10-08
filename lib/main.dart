import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_app/cache/cache_helper.dart';
import 'package:test_api_app/core/api/dio_consumer.dart';
import 'package:test_api_app/cubits/user_cubit/user_cubit.dart';
import 'package:test_api_app/repositories/user_repository.dart';
import 'package:test_api_app/views/sign_in_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(BlocProvider(
    create: (context) => UserCubit(UserRepository(api: DioConsumer(dio: Dio()))),
    child: const TestApiApp(),
  ));
}

class TestApiApp extends StatelessWidget {
  const TestApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInView(),
    );
  }
}
