import 'dart:convert';

import 'package:chat_app_flutter/global/enviroment.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future loginUser(Map<String, dynamic> data) async {
    final resp = await http.post('${Enviroment.apiUrl}/auth',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    return resp;
  }

  Future registerUser(Map<String, dynamic> data) async {
    final resp = await http.post('${Enviroment.apiUrl}/auth/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    return resp;
  }
}
