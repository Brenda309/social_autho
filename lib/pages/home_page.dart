import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_scaffold.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Center(
        child: Text(
          "LOGGED IN AS: " + user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
