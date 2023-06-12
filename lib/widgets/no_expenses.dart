import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/model.dart';

class FlutterBankNoExpenses extends StatelessWidget {
  const FlutterBankNoExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.payments, color: Utils.mainThemeColor, size: 50),
          SizedBox(height: 20),
          Text(
            'There are no expenses\nat the moment.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Utils.mainThemeColor),
          ),
        ],
      ),
    );
  }
}
