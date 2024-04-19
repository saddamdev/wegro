import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              provider.toggleTheme();
            },
            icon: provider.theme == ThemeData.dark()
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'User : ${user.email!}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
