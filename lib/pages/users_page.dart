import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app_flutter/models/user_model.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
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
      body: SmartRefresher(
          enablePullDown: true,
          header: WaterDropMaterialHeader(
            distance: 40,
          ),
          controller: _refreshController,
          onRefresh: _loadUsers,
          child: _listViewUsuarios()),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(users[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: users.length);
  }

  ListTile _usuarioListTile(UserModel user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _loadUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
