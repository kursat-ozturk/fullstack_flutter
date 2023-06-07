import 'package:flutter/material.dart';

import '../models/model.dart';

class FlutterBankLoading extends StatelessWidget {
  const FlutterBankLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Utils.mainThemeColor),
                ),
              ),
            ),
            Center(
              child: Icon(Icons.savings, color: Utils.mainThemeColor, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}
