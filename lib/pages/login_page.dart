// flutter
import 'package:flutter/material.dart';

// widgets
import 'package:chat_app_flutter/widgets/custom_input.dart';
import 'package:chat_app_flutter/widgets/labels.dart';
import 'package:chat_app_flutter/widgets/logo.dart';
import 'package:chat_app_flutter/widgets/terms.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Logo(), _Form(), Labels(), Terms()],
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            keyboardType: TextInputType.text,
            textController: passCtrl,
            isPassword: true,
          )
        ],
      ),
    );
  }
}
