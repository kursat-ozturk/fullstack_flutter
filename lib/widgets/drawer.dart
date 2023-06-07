import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/model.dart';

class FlutterBankDrawer extends StatelessWidget {
  const FlutterBankDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Utils.mainThemeColor,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.savings, color: Colors.white, size: 60),
          const SizedBox(height: 40),
          Material(
            color: Colors.transparent,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.1)),
              ),
              child: const Text(
                'Sign Out',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Utils.signOutDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
