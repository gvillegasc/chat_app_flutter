import 'package:chat_app_flutter/helpers/show_alert.dart';
import 'package:chat_app_flutter/providers/auth_provider.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:flutter/services.dart';

// flutter
import 'package:chat_app_flutter/widgets/button_blue.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:chat_app_flutter/widgets/custom_input.dart';
import 'package:chat_app_flutter/widgets/labels.dart';
import 'package:chat_app_flutter/widgets/logo.dart';
import 'package:chat_app_flutter/widgets/terms.dart';
import 'package:provider/provider.dart';

final authService = AuthService();

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
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
                  Logo(
                    title: 'Ingreso',
                  ),
                  _Form(),
                  Labels(
                    question: '¿No tienes una cuenta?',
                    route: 'register',
                    textButton: 'Crea una cuenta',
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
          ),
          ButtonBlue(
            textButton: "Ingresar",
            onPressedButton: authProvider.authenticating
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final isOk = await authProvider.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (isOk) {
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(
                          context, "Invalid login", "Credentials are invalid");
                    }
                  },
          )
        ],
      ),
    );
  }
}
