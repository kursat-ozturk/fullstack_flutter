import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/data.dart';
import 'package:fullstack_flutter/models/login_service.dart';
import 'package:provider/provider.dart';

import 'expense.dart';

class FlutterBankService extends ChangeNotifier {
  Account? selectedAccount;
  List<Expense> expenses = [];

  void setSelectedAccount(Account? acct) {
    selectedAccount = acct;
    notifyListeners();
  }

  void resetSelections() {
    setSelectedAccount(null);
  }

  Account? getSelectedAccount() {
    return selectedAccount;
  }

  void addExpense(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();

    CollectionReference expensesCollection = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId) //userId
        .collection('user_expenses');

    expensesCollection
        .add({
          'amount': 100,
          'timestamp': DateTime.now().toIso8601String(),
          'name': 'Sample Expense'
        })
        .then((value) => print('document added'))
        .catchError((error) => print('error during adding'));
  }

  void deleteExpense(BuildContext context, String expenseId) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();

    DocumentReference expenseToDelete = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId) //userId
        .collection('user_expenses')
        .doc(expenseId);

    expenseToDelete
        .delete()
        .then((value) => print('document deleted'))
        .catchError((error) => print('error while deleting document'));
  }

  Stream<List<Expense>> getExpenses(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();

    var controller = StreamController<List<Expense>>();

    FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId) //userId
        .collection('user_expenses')
        .snapshots()
        .listen((QuerySnapshot collection) {
      expenses.clear();
      for (var doc in collection.docs) {
        var expenseJson = doc.data() as Map<String, dynamic>;
        expenses.add(Expense.fromJson(expenseJson, doc.id));
      }
      controller.add(expenses);
    });

    return controller.stream;
  }

  Future<List<Account>> getAccounts(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();
    List<Account> accounts = [];
    Completer<List<Account>> accountsCompleter = Completer();

    FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .get()
        .then((QuerySnapshot collection) {
      for (var doc in collection.docs) {
        var acctDoc = doc.data() as Map<String, dynamic>;
        var acct = Account.fromJson(acctDoc, doc.id);
        accounts.add(acct);
      }

      Future.delayed(const Duration(seconds: 1), () {
        accountsCompleter.complete(accounts);
      });
    }, onError: (error) {
      accountsCompleter.completeError({'error': error});
    });

    return accountsCompleter.future;
  }

  Future<bool> performDeposit(BuildContext context) {
    Completer<bool> depositComplete = Completer();

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();

    DepositService depositService =
        Provider.of<DepositService>(context, listen: false);
    int amountToDeposit = depositService.amountToDeposit.toInt();

    DocumentReference doc = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .doc(selectedAccount!.id!);

    doc.update({'balance': selectedAccount!.balance! + amountToDeposit}).then(
        (value) {
      depositService.resetDepositService();
      depositComplete.complete(true);
    }, onError: (error) {
      depositComplete.completeError({'error': error});
    });

    return depositComplete.future;
  }

  Future<bool> performWithdrawal(BuildContext context) {
    Completer<bool> withdrawComplete = Completer();

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();

    WithdrawalService wService =
        Provider.of<WithdrawalService>(context, listen: false);
    int amountToWithdraw = wService.amountToWithdraw.toInt();

    DocumentReference doc = FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .doc(selectedAccount!.id!);

    doc.update({'balance': selectedAccount!.balance! - amountToWithdraw}).then(
        (value) {
      wService.resetWithdrawalService();
      withdrawComplete.complete(true);
    }, onError: (error) {
      withdrawComplete.completeError({'error': error});
    });

    return withdrawComplete.future;
  }
}

class DepositService extends ChangeNotifier {
  double amountToDeposit = 0;
  void setAmountToDeposit(double amount) {
    amountToDeposit = amount;
    notifyListeners();
  }

  void resetDepositService() {
    amountToDeposit = 0;
    notifyListeners();
  }

  bool checkAmountToDeposit() {
    return amountToDeposit > 0;
  }
}

class WithdrawalService extends ChangeNotifier {
  double amountToWithdraw = 0;

  void setAmountToWithdraw(double amount) {
    amountToWithdraw = amount;
    notifyListeners();
  }

  void resetWithdrawalService() {
    amountToWithdraw = 0;
    notifyListeners();
  }

  bool checkAmountToWithdraw() {
    return amountToWithdraw > 0;
  }
}
