import 'package:flutter/material.dart';
import 'package:chat_app_flutter/routes/routes.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, //top bar icons
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'users',
        routes: appRoutes,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ));
  }
}
