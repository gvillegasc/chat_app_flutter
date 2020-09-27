// flutter
import 'package:chat_app_flutter/helpers/show_alert.dart';
import 'package:chat_app_flutter/providers/auth_provider.dart';
import 'package:chat_app_flutter/providers/socket_provider.dart';
import 'package:chat_app_flutter/widgets/button_blue.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:chat_app_flutter/widgets/custom_input.dart';
import 'package:chat_app_flutter/widgets/labels.dart';
import 'package:chat_app_flutter/widgets/logo.dart';
import 'package:chat_app_flutter/widgets/terms.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(title: 'Registro'),
                  _Form(),
                  Labels(
                    question: '¿Ya tienes una cuenta?',
                    route: 'login',
                    textButton: 'Ingresa aqui!',
                  ),
                  Terms()
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person_outline,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
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
          ),
          ButtonBlue(
            textButton: "Crear Cuenta",
            onPressedButton: authProvider.authenticating
                ? null
                : () async {
                    final registerOk = await authProvider.register(
                        nameCtrl.text, emailCtrl.text, passCtrl.text);
                    if (registerOk == true) {
                      socketProvider.connectSocket();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(context, 'Invalid Register', registerOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
