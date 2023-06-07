import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/data.dart';
import 'package:fullstack_flutter/models/login_service.dart';
import 'package:provider/provider.dart';

class FlutterBankService extends ChangeNotifier {
  Future<List<Account>> getAccounts(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String userId = loginService.getUserId();
    List<Account> accounts = [];
    Completer<List<Account>> accountCompleter = Completer();

    FirebaseFirestore.instance
        .collection('accounts')
        .doc('63g1wr4o3iMVL5rHoso1yjFveZh2')
        .collection('user_accounts')
        .get()
        .then((QuerySnapshot collection) {
      for (var doc in collection.docs) {
        var acctDoc = doc.data() as Map<String, dynamic>;
        var acct = Account.fromJson(acctDoc, doc.id);
        accounts.add(acct);
      }

      Future.delayed(const Duration(seconds: 1), () {
        accountCompleter.complete(accounts);
      });
    });

    return accountCompleter.future;
  }
}
