import 'package:flutter/material.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_error.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_loading.dart';
import 'package:fullstack_flutter/widgets/transaction_completed.dart';
import 'package:provider/provider.dart';

import '../models/flutter_bank_service.dart';
import '../models/model.dart';

class TransactionCompletionPage extends StatelessWidget {
  final bool? isDeposit;
  const TransactionCompletionPage({super.key, this.isDeposit});

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService =
        Provider.of<FlutterBankService>(context, listen: false);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Utils.mainThemeColor),
        backgroundColor: Colors.transparent,
        title: const Icon(Icons.savings, color: Utils.mainThemeColor, size: 40),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: bankService.performDeposit(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return FlutterBankLoading();
            }
            if (snapshot.hasError) {
              return FlutterBankError();
            }
            return FlutterBankTransactionCompleted();
          },
        ),
      ),
    );
  }
}
