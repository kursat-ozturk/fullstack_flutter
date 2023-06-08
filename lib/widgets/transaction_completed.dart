import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/model.dart';

class FlutterBankTransactionCompleted extends StatelessWidget {
  const FlutterBankTransactionCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline_outlined,
          color: Utils.mainThemeColor,
          size: 80,
        ),
        SizedBox(height: 20),
        Text(
          'Transaction Completed',
          style: TextStyle(color: Utils.mainThemeColor, fontSize: 20),
        ),
      ],
    );
  }
}
