import 'package:chat_app_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    UserModel(uid: '1', name: 'Maria', online: true, email: 'maria@test.com'),
    UserModel(uid: '2', name: 'Jose', online: false, email: 'jose@test.com'),
    UserModel(uid: '3', name: 'Alessa', online: true, email: 'alessa@test.com'),
    UserModel(
        uid: '4', name: 'Damian', online: false, email: 'damian@test.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mi nombre",
          style: TextStyle(color: Colors.black87),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app, color: Colors.black87)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            // child: Icon(Icons.check_circle, color: Colors.blue[400]),
            child: Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i) => ListTile(
                title: Text(users[i].name),
                leading: CircleAvatar(
                  child: Text(users[i].name.substring(0, 2)),
                ),
                trailing: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: users[i].online ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
          separatorBuilder: (_, i) => Divider(),
          itemCount: users.length),
    );
  }
}
