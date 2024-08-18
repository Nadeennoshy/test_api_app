import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_app/cubits/user_cubit/user_cubit.dart';
import 'package:test_api_app/widgets/custom_form_button.dart';
import 'package:test_api_app/widgets/custom_input_field.dart';
import 'package:test_api_app/widgets/dont_have_an_account.dart';
import 'package:test_api_app/widgets/forget_password.dart';
import 'package:test_api_app/widgets/page_header.dart';
import 'package:test_api_app/widgets/page_heading.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            'Success',
            style: TextStyle(color: Colors.green),
          )));
        } else if (state is SignInFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            'Failure',
            style: TextStyle(color: Colors.red),
          )));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffEEF1F3),
          body: Column(
            children: [
              const PageHeader(),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                      key: context.read<UserCubit>().signInFormKey,
                      child: Column(
                        children: [
                          const PageHeading(title: 'Sign-in'),
                          CustomInputField(
                              controller: context.read<UserCubit>().signInEmail,
                              labelText: 'Email',
                              hintText: 'Your email'),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomInputField(
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            controller:
                                context.read<UserCubit>().signInPassword,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ForgetPasswordWidget(size: size),
                          const SizedBox(
                            height: 20,
                          ),
                          state is SignInLoadingState
                              ? const CircularProgressIndicator()
                              : CustomFormButton(
                                  innerText: 'Sign In',
                                  onPressed: () {
                                    context.read<UserCubit>().signIn();
                                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                                    //   return const ProfileView();
                                    // }));
                                  }),
                          const SizedBox(
                            height: 18,
                          ),
                          DontHaveAnAccount(size: size),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ),
              )),
            ],
          ),
        );
      },
    ));
  }
}
