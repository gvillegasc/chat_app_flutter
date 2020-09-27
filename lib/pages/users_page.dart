import 'package:chat_app_flutter/providers/auth_provider.dart';
import 'package:chat_app_flutter/providers/socket_provider.dart';
import 'package:chat_app_flutter/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app_flutter/models/user_model.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userService = UserService();
  List<UserModel> users = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    this._loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    final user = authProvider.user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user.name,
          style: TextStyle(color: Colors.black87),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              authProvider.logout();
              socketProvider.disconnectSocket();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.exit_to_app, color: Colors.black87)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),

            // child: ,
            child: (socketProvider.serverStatus == ServerStatus.Online)
                ? Icon(Icons.wifi_tethering, color: Colors.green)
                : Icon(Icons.portable_wifi_off, color: Colors.red),
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
    this.users = await userService.getUsers();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
