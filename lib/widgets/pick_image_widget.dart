import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_api_app/cubits/user_cubit/user_cubit.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SizedBox(
            width: 130,
            height: 130,
            child: context.read<UserCubit>().profilePic == null
                ? CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        const AssetImage('assets/images/avatar.png'),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () async {},
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    ImagePicker()
                                        .pickImage(source: ImageSource.gallery)
                                        .then((value) => context
                                            .read<UserCubit>()
                                            .uploadProfilePic(value!));
                                  },
                                  child: const Icon(
                                    Icons.camera_alt_sharp,
                                    color: Color.fromARGB(255, 243, 234, 234),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(
                        File(context.read<UserCubit>().profilePic!.path)),
                  ),
          );
        });
  }
}
