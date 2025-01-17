import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/battery.dart';
import '../services/connectivity_service.dart';
import 'main_scaffold.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "LOGGED IN AS: " + user.email!,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),  // Add some spacing
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnectivityCheckPage()),
              );
            },
            child: Text('Check Internet Connectivity'),
          ),
          SizedBox(height: 20),  // Add some spacing
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BatteryPage()), // Navigate to BatteryPage
              );
            },
            child: Text('Check Battery Status'),
          ),
        ],
      ),
    );
  }
}
