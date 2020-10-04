import 'dart:io';

import 'package:chat_app_flutter/global/colors_app.dart';
import 'package:chat_app_flutter/models/message_response.dart';
import 'package:chat_app_flutter/providers/auth_provider.dart';
import 'package:chat_app_flutter/providers/chat_provider.dart';
import 'package:chat_app_flutter/providers/socket_provider.dart';
import 'package:chat_app_flutter/services/chat_service.dart';
import 'package:chat_app_flutter/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  final chatService = ChatService();

  ChatProvider chatProvider;
  SocketProvider socketProvider;
  AuthProvider authProvider;

  List<ChatMessage> _messages = [];
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    this.chatProvider = Provider.of<ChatProvider>(context, listen: false);
    this.socketProvider = Provider.of<SocketProvider>(context, listen: false);
    this.authProvider = Provider.of<AuthProvider>(context, listen: false);
    this.socketProvider.socket.on('personal-message', _listenMessage);
    _loadHistory(this.chatProvider.userFrom.uid);
  }

  void _loadHistory(String userId) async {
    List<Message> chat = await this.chatService.getChat(userId);
    final history = chat.map((m) => ChatMessage(
          text: m.message,
          uid: m.by,
          animationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 0))
            ..forward(),
        ));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = new ChatMessage(
        text: payload['message'],
        uid: payload['uid'],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 200)));

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userFrom = chatProvider.userFrom;
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: ColorsApp.primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 15,
              child: Text(
                userFrom.name.substring(0, 2),
                style: TextStyle(fontSize: 12, color: ColorsApp.primaryColor),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              userFrom.name,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (_, i) => _messages[i])),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                textInputAction: TextInputAction.send,
                cursorColor: ColorsApp.primaryColor,
                onEditingComplete: () => _handleSubmit(_textController.text),
                // onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    if (text.trim().length > 0) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar Mensaje"),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text("Enviar"),
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(
                          color: ColorsApp.primaryColor,
                        ),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                            color: _isWriting ? ColorsApp.primaryColor : null,
                          ),
                          onPressed: _isWriting
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  // _asd() {
  //   _textController.clear();
  //   FocusScope.of(context).requestFocus(_focusNode);
  // }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();

    _isWriting = false;

    final newMessage = new ChatMessage(
      uid: authProvider.user.uid,
      text: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    this.socketProvider.emit('personal-message', {
      'by': this.authProvider.user.uid,
      'from': this.chatProvider.userFrom.uid,
      'message': texto
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    this.socketProvider.socket.off('personal-message');

    super.dispose();
  }
}
