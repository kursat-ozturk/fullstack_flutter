import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/flutter_bank_service.dart';
import 'package:fullstack_flutter/widgets/account_card.dart';
import 'package:fullstack_flutter/widgets/drawer.dart';
import 'package:fullstack_flutter/widgets/flutter_bank_loading.dart';
import 'package:provider/provider.dart';

import '../models/data.dart';
import '../models/model.dart';
import '../widgets/bottom_bar.dart';

class FlutterBankMain extends StatelessWidget {
  const FlutterBankMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(child: FlutterBankDrawer()),
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
          children: [
            const Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: Utils.mainThemeColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'My Accounts',
                  style: TextStyle(color: Utils.mainThemeColor, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<FlutterBankService>(
                builder: (context, bankService, child) {
                  return FutureBuilder(
                    future: bankService.getAccounts(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done ||
                          !snapshot.hasData) {
                        return const FlutterBankLoading();
                      }

                      List<Account> accounts = snapshot.data as List<Account>;
                      if (accounts.isEmpty) {
                        return const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_balance_wallet,
                                  color: Utils.mainThemeColor, size: 50),
                              SizedBox(height: 20),
                              Text(
                                'You don\'t have any accounts\nassociated with your profile.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Utils.mainThemeColor),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          var acct = accounts[index];
                          return AccountCard(account: acct);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FlutterBankBottomBar(),
    );
  }
}
