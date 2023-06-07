import 'package:flutter/material.dart';
import 'package:fullstack_flutter/pages/account_registration.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/main_page.dart';
import '../pages/splash_page.dart';

class FlutterBankApp extends StatelessWidget {
  const FlutterBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FlutterBankMain(), //FlutterBankSplash(),
    );
  }
}
