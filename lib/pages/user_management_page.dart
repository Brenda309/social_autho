import 'package:flutter/material.dart';
import 'main_scaffold.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final List<Map<String, String>> _users = [
    {'email': 'user1@example.com', 'username': 'User1'},
    {'email': 'user2@example.com', 'username': 'User2'},
    // Add more hardcoded users if needed
  ];

  void _updateUser(int index, String newUsername) {
    setState(() {
      _users[index]['username'] = newUsername;
    });
  }

  void _deleteUser(int index) {
    setState(() {
      _users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user['username']!),
            subtitle: Text(user['email']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteUser(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditDialog(int index) {
    final TextEditingController _controller =
    TextEditingController(text: _users[index]['username']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Username'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'New Username'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateUser(index, _controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
