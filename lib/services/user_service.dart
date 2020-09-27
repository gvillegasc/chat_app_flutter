import 'package:chat_app_flutter/global/enviroment.dart';
import 'package:chat_app_flutter/models/user_model.dart';
import 'package:chat_app_flutter/models/user_response.dart';
import 'package:chat_app_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<UserModel>> getUsers() async {
    try {
      final token = await AuthProvider.getToken();
      final resp = await http.get('${Enviroment.apiUrl}/user',
          headers: {'Conent-Type': 'application/json', 'x-token': token});

      final userResponse = userResponseFromJson(resp.body);
      return userResponse.users;
    } catch (err) {
      return [];
    }
  }
}
