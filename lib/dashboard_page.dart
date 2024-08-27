import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String token;
  final String username;
  final String password;

  const DashboardPage({
    super.key,
    required this.username,
    required this.password,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome $username! Your token is $token'),
      ),
    );
  }
}
