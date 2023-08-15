import 'package:flutter/material.dart';
import 'package:shopping_helper_flutter/widgets/shopping_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          surface: Colors.amber[100],
        ),
        scaffoldBackgroundColor: Colors.amber[50],
      ),
      home: const ShoppingList(),
    );
  }
}