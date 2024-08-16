import 'package:flutter/material.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key,required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width*0.80,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: (){

        },
        child: const Text('Forget Password?',
        style: TextStyle(
          color: Color(0xff939393),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}