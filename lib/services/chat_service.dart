import 'package:chat_app_flutter/global/enviroment.dart';
import 'package:chat_app_flutter/models/message_response.dart';
import 'package:chat_app_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class ChatService {
  Future<List<Message>> getChat(String userId) async {
    final resp = await http.get('${Enviroment.apiUrl}/message/$userId',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthProvider.getToken()
        });
    final messageResp = messageResponseFromJson(resp.body);
    return messageResp.messages;
  }
}
