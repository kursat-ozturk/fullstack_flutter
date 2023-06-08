import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/data.dart';
import 'package:fullstack_flutter/models/login_service.dart';
import 'package:provider/provider.dart';

class FlutterBankService extends ChangeNotifier {
  Account? selectedAccount;

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
