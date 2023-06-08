import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class AccountDepositSlider extends StatelessWidget {
  const AccountDepositSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DepositService>(
      builder: (context, depositService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Amount To Deposit',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              '\$${depositService.amountToDeposit.toInt().toString()}',
              style: const TextStyle(color: Colors.black, fontSize: 60),
            ),
            Slider(
              value: depositService.amountToDeposit,
              max: 1000,
              activeColor: Utils.mainThemeColor,
              inactiveColor: Colors.grey.withOpacity(0.5),
              thumbColor: Utils.mainThemeColor,
              onChanged: (double value) {
                depositService.setAmountToDeposit(value);
              },
            ),
          ],
        );
      },
    );
  }
}
