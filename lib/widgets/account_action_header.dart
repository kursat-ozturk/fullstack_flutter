import 'package:flutter/material.dart';

import '../models/model.dart';

class AccountActionHeader extends StatelessWidget {
  final String? headerTitle;
  final IconData? icon;
  const AccountActionHeader({super.key, this.headerTitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: Utils.mainThemeColor, size: 30),
          const SizedBox(width: 10),
          Text(
            headerTitle!,
            style: const TextStyle(color: Utils.mainThemeColor, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
