import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:session5_task/features/authentication/presentation/pages/login_page.dart';
import 'package:session5_task/features/authentication/presentation/pages/register_page.dart';

UserCredential? userCredential;
bool isInitialized = false;
final GoogleSignIn googleSignIn = GoogleSignIn.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: RegisterPage()));
}
