import 'dart:convert';

import 'package:chat_app_flutter/models/login_response.dart';
import 'package:chat_app_flutter/models/user_model.dart';
import 'package:chat_app_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authService = AuthService();

class AuthProvider with ChangeNotifier {
  UserModel user;
  bool _authenticating = false;

  final _storage = new FlutterSecureStorage();

  // Getters
  bool get authenticating => this._authenticating;

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  // Setters
  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    this.authenticating = true;
    final data = {'email': email, 'password': password};
    final response = await authService.loginUser(data);
    this.authenticating = false;
    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    this.authenticating = true;
    final data = {'name': name, 'email': email, 'password': password};
    final response = await authService.registerUser(data);
    this.authenticating = false;
    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(response.body);
      return respBody['message'];
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
