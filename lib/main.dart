import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:session5_task/features/authentication/presentation/pages/home_page.dart';
import 'package:session5_task/features/authentication/presentation/pages/login_page.dart';
import 'package:session5_task/features/authentication/presentation/pages/register_page.dart';
import 'package:session5_task/features/authentication/presentation/pages/settings_page.dart';
import 'package:session5_task/features/authentication/presentation/pages/success_page.dart';
import 'package:session5_task/firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "/register": (context) => RegisterPage(),
        "/login": (context) => LoginPage(),
        "/settings": (context) => SettingsPage(),
        "/success": (context) => SuccessPage(),
      },
    ),
  );
}
