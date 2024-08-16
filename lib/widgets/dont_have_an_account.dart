import 'package:flutter/material.dart';
import 'package:test_api_app/views/sign_up_view.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key,required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width*0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Don\'t have an account ? ',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff939393),
            fontWeight: FontWeight.bold,
          ),),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const SignUpView();
              }));
            },
            child: const Text('Sign-up',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff748288),
              fontWeight: FontWeight.bold,
            ),),
          ),
        ],
      ),
    );
  }
}