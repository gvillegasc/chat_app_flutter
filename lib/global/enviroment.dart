import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid
      ? 'https://flutter-chat-app-server.herokuapp.com/api'
      : 'https://flutter-chat-app-server.herokuapp.com/api';
  static String socketUrl = Platform.isAndroid
      ? 'https://flutter-chat-app-server.herokuapp.com'
      : 'https://flutter-chat-app-server.herokuapp.com';
}
