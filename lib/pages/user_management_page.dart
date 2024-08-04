import 'package:flutter/material.dart';
import 'main_scaffold.dart';

class User {
  final String uid;
  final String email;
  final String username;

  User({
    required this.uid,
    required this.email,
    required this.username,
  });
}

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<User> _users = [
    User(uid: 'Brenda', email: 'brenda@gmail.com', username: 'Brenda'),
    User(uid: '2', email: 'nana@gmail.com', username: 'Nana'),
    // Add more hardcoded users here
       User(uid: '1', email: 'wih.com', username: 'Wihgora'),
        User(uid: '2', email: 'bre@gmail.com', username: 'bre'),

  ];

  void _addUser(User user) {
    setState(() {
      _users.add(user);
    });
  }

  void _deleteUser(String uid) {
    setState(() {
      _users.removeWhere((user) => user.uid == uid);
    });
  }

  void _updateUser(String uid, String newUsername) {
    setState(() {
      int index = _users.indexWhere((user) => user.uid == uid);
      if (index != -1) {
        _users[index] = User(
          uid: uid,
          email: _users[index].email,
          username: newUsername,
        );
      }
    });
  }

  void _showUpdateDialog(BuildContext context, String uid, String currentUsername) {
    final _usernameController = TextEditingController(text: currentUsername);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Username'),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateUser(uid, _usernameController.text);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          User user = _users[index];
          return ListTile(
            title: Text(user.username),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showUpdateDialog(context, user.uid, user.username);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteUser(user.uid);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
