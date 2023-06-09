import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class AccountWithdrawalSlider extends StatelessWidget {
  const AccountWithdrawalSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FlutterBankService>(
      builder: (context, bankService, child) {
        return Consumer<WithdrawalService>(
          builder: (context, withdrawalService, child) {
            double amountToWithdraw = withdrawalService.amountToWithdraw;
            double currentBalance =
                bankService.selectedAccount!.balance! as double;
            double actualAmount = amountToWithdraw > currentBalance
                ? currentBalance
                : amountToWithdraw;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Amount To Withdraw',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '\$${actualAmount.toInt().toString()}',
                  style: const TextStyle(color: Colors.black, fontSize: 60),
                ),
                Slider(
                  value: actualAmount,
                  max: 1000, //bankService.selectedAccount!.balance,
                  activeColor: Utils.mainThemeColor,
                  inactiveColor: Colors.grey.withOpacity(0.5),
                  thumbColor: Utils.mainThemeColor,
                  onChanged: (double value) {
                    withdrawalService.setAmountToWithdraw(value);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
