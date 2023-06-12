import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/model.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense? expense;
  final Function? onDeleteExpense;

  const ExpenseCard({super.key, this.expense, this.onDeleteExpense});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense!.name!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 12)),
              Row(
                children: [
                  const Icon(Icons.monetization_on,
                      color: Utils.mainThemeColor, size: 20),
                  Text('\$${expense!.amount!.toStringAsFixed(2)}',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 25)),
                ],
              ),
              Text(
                DateFormat.yMd()
                    .add_jm()
                    .format(DateTime.parse(expense!.timestamp!)),
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.grey),
                onPressed: () {
                  onDeleteExpense!();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
