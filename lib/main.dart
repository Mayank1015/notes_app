import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/services/spf.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/services/provider.dart';
import 'package:notes_app/pages/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPF.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesListProvider(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        // home: const OnBoardingScreen(),
        home: SPF.prefs.getBool("isLoggedIn") == true
            ? const MyHomePage()
            : const OnBoardingScreen(),
      ),
    );
  }
}
