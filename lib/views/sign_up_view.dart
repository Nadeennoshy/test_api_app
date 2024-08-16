import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_app/cubits/user_cubit/user_cubit.dart';
import 'package:test_api_app/widgets/already_have_an_account_widget.dart';
import 'package:test_api_app/widgets/custom_form_button.dart';
import 'package:test_api_app/widgets/custom_input_field.dart';
import 'package:test_api_app/widgets/page_header.dart';
import 'package:test_api_app/widgets/page_heading.dart';
import 'package:test_api_app/widgets/pick_image_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xffEEF1F3),
      body: SingleChildScrollView(
        child: Form(
          key: context.read<UserCubit>().signUpFormKey,
          child: Column(
            children: [
              const PageHeader(),
              const PageHeading(title: 'Sign-up'),
              const PickImageWidget(),
              const SizedBox(height: 16,),
              CustomInputField(labelText: 'Name', hintText: 'Your name',inDense: true,
              controller: context.read<UserCubit>().signUpName,),
              const SizedBox(height: 16,),
              CustomInputField(labelText: 'Email', hintText: 'Your email',inDense: true,
              controller: context.read<UserCubit>().signUpEmail,),
              const SizedBox(height: 16,),
              CustomInputField(labelText: 'Phone number', hintText: 'Your phone number ex:01234567890',
              inDense: true,
              controller: context.read<UserCubit>().signUpPhoneNumber,),
              const SizedBox(height: 16,),
              CustomInputField(labelText: 'Password', hintText: 'Your password',inDense: true,obscureText: true,suffixIcon: true,
              controller: context.read<UserCubit>().signUpPassword,),
              CustomInputField(labelText: 'Confirm Password', hintText: 'Confirm your password',
              inDense: true,obscureText: true,suffixIcon: true,
              controller: context.read<UserCubit>().signUpConfirmPassword,),
              const SizedBox(height: 22,),
              CustomFormButton(innerText: 'Signup', onPressed: (){}),
              const SizedBox(height: 18,),
              const AlreadyHaveAnAccountWidget(),
              const SizedBox(height: 30,),

            ],
          )),
      ),
    ));
  }
}