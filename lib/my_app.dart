import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/sign_in_screen.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WeGro',
          theme: provider.theme,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const SignInScreen();
              }
            },
          ),
        );
      },
    );
  }
}
