import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(FlutterBankApp());
}
