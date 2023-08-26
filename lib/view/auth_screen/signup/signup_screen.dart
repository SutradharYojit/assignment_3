import 'package:assignment_3/routes/routes_name.dart';
import 'package:assignment_3/services/firebase_auth.dart';
import 'package:assignment_3/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../resources/resources.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("SignUp")),
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
                      await FirebaseAuthServices()
                          .signUP(context, textEmail: _emailCtrl.text.trim(), textPass: _passCtrl.text.trim());
                    },
                    child: const Text("Sign Up"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.go(RoutesName.loginScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(color: ColorManager.blackColor, fontSize: 13, fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\tLogin',
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
