import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:fullstack_flutter/models/model.dart';
import 'package:fullstack_flutter/widgets/account_action_header.dart';
import 'package:fullstack_flutter/widgets/bank_main_button.dart';
import 'package:fullstack_flutter/widgets/expense.card.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_error.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_loading.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../widgets/no_expenses.dart';

class FlutterBankExpenses extends StatelessWidget {
  const FlutterBankExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterBankService bankService =
        Provider.of<FlutterBankService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Utils.mainThemeColor),
        backgroundColor: Colors.transparent,
        title: const Icon(Icons.savings, color: Utils.mainThemeColor, size: 40),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AccountActionHeader(
              icon: Icons.payments,
              headerTitle: 'My Expenses',
            ),
            Expanded(
              child: StreamBuilder<List<Expense>>(
                stream: bankService.getExpenses(context),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return FlutterBankLoading();
                  }

                  if (snapshot.hasError) {
                    return FlutterBankError();
                  }

                  var expenses = snapshot.data as List<Expense>;

                  if (expenses.isEmpty) {
                    return FlutterBankNoExpenses();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      var expense = expenses[index];
                      return ExpenseCard(
                        expense: expense,
                        onDeleteExpense: () {
                          bankService.deleteExpense(context, expense.id!);
                        },
                      );
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            FlutterBankMainButton(
              label: 'Add Expense',
              onTap: () {
                bankService.addExpense(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
