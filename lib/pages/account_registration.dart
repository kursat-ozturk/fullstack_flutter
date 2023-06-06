import 'package:flutter/material.dart';
import 'package:fullstack_flutter/models/login_service.dart';
import 'package:fullstack_flutter/widgets/bank_main_button.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class FlutterAccountRegistration extends StatefulWidget {
  const FlutterAccountRegistration({super.key});

  @override
  State<FlutterAccountRegistration> createState() =>
      _FlutterAccountRegistrationState();
}

class _FlutterAccountRegistrationState
    extends State<FlutterAccountRegistration> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

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
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(
                          color: Utils.mainThemeColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    //email field
                    Utils.generateInputField(
                        'Email', Icons.email, usernameController, false,
                        (text) {
                      setState(() {});
                    }),
                    //password field
                    Utils.generateInputField(
                        'Password', Icons.lock, passwordController, true,
                        (text) {
                      setState(() {});
                    }),
                    //password confirmation field
                    Utils.generateInputField('Confirm Password', Icons.lock,
                        confirmPasswordController, true, (text) {
                      setState(() {});
                    }),
                  ],
                ),
              ),
            ),
            FlutterBankMainButton(
              label: 'Register',
              enabled: validateFormFields(),
              onTap: () async {
                String username = usernameController.value.text;
                String pwd = passwordController.value.text;
                bool accountCreated = await loginService
                    .createUserWithEmailAndPassword(username, pwd);
                if (accountCreated) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool validateFormFields() {
    return Utils.validateEmail(usernameController.value.text) &&
        usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        confirmPasswordController.value.text.isNotEmpty &&
        (passwordController.value.text == confirmPasswordController.value.text);
  }
}
