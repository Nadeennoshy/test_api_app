import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_app/cubits/user_cubit/user_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GetUserLoading? const Center(child: CircularProgressIndicator()): state is GetUserSuccess? ListView(
            children: [
              const SizedBox(
                height: 16,
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(state.user.profilePic),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                title: Text(state.user.name),
                leading: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                title: Text(state.user.email),
                leading: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                title: Text(state.user.phone),
                leading: const Icon(Icons.phone),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                title: Text(state.user.location['type']),
                leading: const Icon(Icons.location_city),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ):Container(),
        );
      },
    );
  }
}
