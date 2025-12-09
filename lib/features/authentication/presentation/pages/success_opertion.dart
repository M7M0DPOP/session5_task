import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessOpertion extends StatelessWidget {
  final UserCredential userCredential;
  const SuccessOpertion({super.key, required this.userCredential});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 23, 28),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Operation Successful',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your operation was completed successfully.',
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),
            Text(
              'The Email is : ${userCredential.user?.email}\nThe UID is : ${userCredential.user?.uid}  ',
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
