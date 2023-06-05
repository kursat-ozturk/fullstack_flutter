import 'package:flutter/material.dart';

class FlutterBankLogin extends StatefulWidget {
  const FlutterBankLogin({super.key});

  @override
  State<FlutterBankLogin> createState() => _FlutterBankLoginState();
}

class _FlutterBankLoginState extends State<FlutterBankLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}
