import 'package:flutter/material.dart';
import 'package:task_management/screens/home/screen.home.dart';
import 'package:task_management/screens/login/screen.login.dart';
import 'package:task_management/services/service.auth.dart';
import 'package:task_management/theme/theme.app.dart';

void main() {
  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // This will follow the system theme
      home: FutureBuilder<bool>(
        future: AuthService().isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return snapshot.data == true
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
