import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_helper_flutter/screens/new_item.dart';
import 'package:shopping_helper_flutter/screens/shopping_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Helper',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          surface: Colors.amber[100],
        ),
        scaffoldBackgroundColor: Colors.amber[50],
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      home: const ShoppingList(),
      routes: {
        '/new-item': (context) => const NewItem(),
        '/shopping-list': (context) => const ShoppingList(),
      },
    );
  }
}
