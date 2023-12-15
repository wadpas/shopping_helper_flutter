import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_helper_flutter/providers/app_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 64,
            ),
            child: Image.asset('assets/images/auth-logo.png'),
          ),
          Text(
            'Authentication',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextButton.icon(
            onPressed: () {
              context.read<AppProvider>().logInWithGoogle();
            },
            icon: const ImageIcon(
              AssetImage('assets/images/g-logo.png'),
            ),
            label: const Text(
              'Google',
              style: TextStyle(fontSize: 20),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              context.read<AppProvider>().signInAnonymous();
            },
            icon: const ImageIcon(
              AssetImage('assets/images/a-logo.png'),
            ),
            label: const Text(
              'Anonymous',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
