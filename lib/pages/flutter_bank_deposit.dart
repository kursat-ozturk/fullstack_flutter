import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:fullstack_flutter/pages/transaction_completion_page.dart';
import 'package:fullstack_flutter/widgets/account_action_header.dart';
import 'package:fullstack_flutter/widgets/account_action_selection.dart';
import 'package:fullstack_flutter/widgets/account_deposit_slider.dart';
import 'package:fullstack_flutter/widgets/bank_main_button.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class FlutterBankDeposit extends StatelessWidget {
  const FlutterBankDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService =
        Provider.of<FlutterBankService>(context, listen: false);

    Future.delayed(const Duration(seconds: 10), () {
      bankService.resetSelections();
      Navigator.of(context).pop();
    });

    return WillPopScope(
      onWillPop: () {
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
              AccountActionHeader(headerTitle: 'Deposit', icon: Icons.login),
              Expanded(
                child: AccountActionSelection(
                  actionTypeLabel: 'To',
                  amountChanger: AccountDepositSlider(),
                ),
              ),
              Consumer<DepositService>(
                builder: (context, service, child) {
                  return FlutterBankMainButton(
                      enabled: service.checkAmountToDeposit(),
                      label: 'Make Deposit',
                      onTap: service.checkAmountToDeposit()
                          ? () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) =>
                                    const TransactionCompletionPage(
                                        isDeposit: true),
                              ));
                            }
                          : null);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
