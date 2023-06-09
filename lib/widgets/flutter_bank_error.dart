import 'package:flutter/material.dart';

import '../models/model.dart';

class FlutterBankError extends StatelessWidget {
  const FlutterBankError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.warning_outlined, color: Utils.mainThemeColor, size: 80),
          SizedBox(height: 20),
          Text(
            'Error fetching data',
            style: TextStyle(color: Utils.mainThemeColor, fontSize: 20),
          ),
          Text(
            'Please try again',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
