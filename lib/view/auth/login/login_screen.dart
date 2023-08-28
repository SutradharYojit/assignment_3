import 'package:assignment_3/routes/routes_name.dart';
import 'package:assignment_3/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../resources/resources.dart';
import '../../../services/firebase_services.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final bar = WarningBar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Todo List",
                    style: TextStyle(fontSize: 45),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: PrimaryTextFilled(
                    controller: _emailCtrl,
                    hintText: "Enter Email",
                    labelText: "Email",
                  ),
                ),
                PrimaryPassField(
                  textPassCtrl: _passCtrl,
                  hintText: "Enter Password",
                  labelText: "Password",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                      if (_emailCtrl.text.trim() == "" ||
                          _emailCtrl.text.trim().isEmpty ||
                          _passCtrl.text.trim() == "" ||
                          _passCtrl.text.trim().isEmpty) {
                        final notExist = bar.snack("Enter all Filled", ColorManager.redColor);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(notExist);
                      } else {
                        await FirebaseServices().signIN(
                          context,
                          textEmail: _emailCtrl.text.trim(),
                          textPass: _passCtrl.text.trim(),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.go(RoutesName.signupScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(color: ColorManager.blackColor, fontSize: 13, fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\tSign up',
                              style: TextStyle(
                                color: ColorManager.lightBlueColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
