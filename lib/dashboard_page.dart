import 'package:flutter/material.dart';
import 'main.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  final String password;

  const DashboardPage({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State createState() => _DashboardPageState();
}

class _DashboardPageState extends State {
  List<Map<String, String>> users = [
  ];

  void _addUser() {
    setState(() {
      users.add({'name': 'New User', 'username': 'newuser'});
    });
  }

  void _editUser(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String newName = users[index]['name'] ?? '';
        String newUsername = users[index]['username'] ?? '';
        return AlertDialog(
          title: const Text('Edit User'),
          content: SingleChildScrollView( // Wrap in SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    newName = value;
                  },
                  controller: TextEditingController(text: users[index]['name']),
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  onChanged: (value) {
                    newUsername = value;
                  },
                  controller: TextEditingController(text: users[index]['username']),
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  users[index]['name'] = newName;
                  users[index]['username'] = newUsername;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['name'] ?? 'No Name'),
            subtitle: Text(users[index]['username'] ?? 'No Username'),
            onTap: () => _editUser(index),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteUser(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}