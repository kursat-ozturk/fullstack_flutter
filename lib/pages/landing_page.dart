import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/login_service.dart';
import 'package:fullstack_flutter/pages/account_registration.dart';
import 'package:fullstack_flutter/widgets/bank_main_button.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import 'main_page.dart';

class FlutterBankLogin extends StatefulWidget {
  const FlutterBankLogin({super.key});

  @override
  State<FlutterBankLogin> createState() => _FlutterBankLoginState();
}

class _FlutterBankLoginState extends State<FlutterBankLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validateEmailAndPassword() {
    return usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        Utils.validateEmail(usernameController.value.text);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 7,
                  color: Utils.mainThemeColor,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.savings,
                color: Utils.mainThemeColor,
                size: 45,
              ),
            ),
            const SizedBox(height: 30),
            const Text('Welcome to',
                style: TextStyle(color: Colors.grey, fontSize: 15)),
            const Text('Flutter\nSavings Bank',
                style: TextStyle(color: Utils.mainThemeColor, fontSize: 30)),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sign Into Your Bank Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.email, color: Utils.mainThemeColor),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              bottom: 11,
                              top: 11,
                              right: 15,
                            ),
                            hintText: "Email",
                          ),
                          style: const TextStyle(fontSize: 16),
                          controller: usernameController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {});
                          },
                          obscureText: true,
                          obscuringCharacter: "*",
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.lock, color: Utils.mainThemeColor),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 11,
                              top: 11,
                              right: 15,
                            ),
                            hintText: "Password",
                          ),
                          controller: passwordController,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Consumer<LoginService>(
                        builder: (context, lService, child) {
                          String errorMsg = lService.getErrorMessage();
                          if (errorMsg.isEmpty) {
                            return const SizedBox(height: 40);
                          }
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(Icons.warning, color: Colors.red),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    errorMsg,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FlutterBankMainButton(
              label: 'Sign In',
              enabled: validateEmailAndPassword(),
              onTap: () async {
                var username = usernameController.value.text;
                var pwd = passwordController.value.text;

                bool isLoggedIn = await loginService.signInWithEmailAndPassword(
                    username, pwd);

                if (isLoggedIn) {
                  usernameController.clear();
                  passwordController.clear();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FlutterBankMain()));
                }
              },
            ),
            const SizedBox(height: 10),
            FlutterBankMainButton(
              label: 'Register',
              icon: Icons.account_circle,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FlutterAccountRegistration()));
              },
              backgroundColor: Colors.green,
              iconColor: Colors.white,
              labelColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
