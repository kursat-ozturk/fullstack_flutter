import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      home: const FlutterBankSplash(),
    );
  }
}
