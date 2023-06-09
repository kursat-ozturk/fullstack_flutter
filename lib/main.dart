import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:fullstack_flutter/models/login_service.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_app.dart';
import 'package:firebase_core/firebase_core.dart';
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
      ChangeNotifierProvider(
        create: (_) => DepositService(),
      ),
      ChangeNotifierProvider(
        create: (_) => WithdrawalService(),
      ),
    ],
    child: const FlutterBankApp(),
  ));
}
