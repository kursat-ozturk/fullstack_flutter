import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:fullstack_flutter/pages/transaction_completion_page.dart';
import 'package:fullstack_flutter/widgets/account_action_header.dart';
import 'package:fullstack_flutter/widgets/account_action_selection.dart';
import 'package:fullstack_flutter/widgets/bank_main_button.dart';
import 'package:fullstack_flutter/widgets/withdrawal_slider.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class FlutterBankWithdrawal extends StatelessWidget {
  const FlutterBankWithdrawal({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FlutterBankService bankService =
            Provider.of<FlutterBankService>(context, listen: false);
        bankService.resetSelections();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Utils.mainThemeColor),
          backgroundColor: Colors.transparent,
          title:
              const Icon(Icons.savings, color: Utils.mainThemeColor, size: 40),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AccountActionHeader(
                  headerTitle: 'Withdraw', icon: Icons.logout),
              const Expanded(
                child: AccountActionSelection(
                  actionTypeLabel: 'From',
                  amountChanger: AccountWithdrawalSlider(),
                ),
              ),
              Consumer<WithdrawalService>(
                builder: (context, withdrawalService, child) {
                  return FlutterBankMainButton(
                    enabled: withdrawalService.checkAmountToWithdraw(),
                    label: 'Make Withdrawal',
                    onTap: withdrawalService.checkAmountToWithdraw()
                        ? () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TransactionCompletionPage(
                                        isDeposit: false),
                              ),
                            );
                          }
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
