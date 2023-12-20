import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shopping_helper_flutter/providers/app_provider.dart';
import 'package:shopping_helper_flutter/screens/auth_screen.dart';
import 'package:shopping_helper_flutter/screens/new_product.dart';
import 'package:shopping_helper_flutter/screens/shopping_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        )
      ],
      child: MaterialApp(
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
        home: Consumer<AppProvider>(
          builder: (context, value, child) {
            return value.isLoading
                ? const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : value.userId == null
                    ? const AuthScreen()
                    : const ShoppingList();
          },
        ),
        routes: {
          '/new-product': (context) => const NewProduct(),
          '/shopping-list': (context) => const ShoppingList(),
        },
      ),
    );
  }
}
