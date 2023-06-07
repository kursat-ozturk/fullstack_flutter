import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:fullstack_flutter/models/login_service.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginService(),
      ),
      ChangeNotifierProvider(
        create: (_) => FlutterBankService(),
      ),
    ],
    child: FlutterBankApp(),
  ));
}
