import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_app/cubits/user_cubit/user_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            children: [
              const SizedBox(
                height: 16,
              ),
              CircleAvatar(
                radius: 80,
                child: Image.asset('assets/images/avatar.png'),
              ),
              const SizedBox(
                height: 16,
              ),
              const ListTile(
                title: Text('Name'),
                leading: Icon(Icons.person),
              ),
              const SizedBox(
                height: 16,
              ),
              const ListTile(
                title: Text('Email'),
                leading: Icon(Icons.email),
              ),
              const SizedBox(
                height: 16,
              ),
              const ListTile(
                title: Text('phone number'),
                leading: Icon(Icons.phone),
              ),
              const SizedBox(
                height: 16,
              ),
              const ListTile(
                title: Text('Address'),
                leading: Icon(Icons.location_city),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
