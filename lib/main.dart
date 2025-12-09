import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:session5_task/features/authentication/presentation/pages/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: RegisterPage()));
}
