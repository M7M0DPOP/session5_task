import 'package:flutter/material.dart';
import 'package:session5_task/features/authentication/presentation/pages/home_page.dart';
import 'package:session5_task/features/authentication/presentation/pages/success_page.dart';
import 'package:session5_task/features/authentication/presentation/widgets/custom_elevated_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Page')),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'With Navigator 1.0',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            CustomElevatedButton(
              backgroundColor: Colors.blue,
              child: const Text(
                'Go back',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CustomElevatedButton(
              backgroundColor: Colors.blue,
              child: const Text(
                'Go next',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuccessPage()),
                );
              },
            ),
            Text(
              'With Navigator 2.0',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            CustomElevatedButton(
              backgroundColor: Colors.blue,
              child: const Text(
                'Go back',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CustomElevatedButton(
              backgroundColor: Colors.blue,
              child: const Text(
                'Go next',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
