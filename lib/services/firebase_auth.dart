import 'dart:developer';
import 'package:assignment_3/routes/routes_name.dart';
import 'package:assignment_3/services/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../resources/color_manager.dart';
import '../widget/widget.dart';

class FirebaseAuthServices {
  final bar = WarningBar();
  final userPreferences = UserPreferences();

  Future signUP(BuildContext context, {required String textEmail, required String textPass}) async {
    final notExist = bar.snack("Account Already exist", ColorManager.redColor);
    debugPrint("Button pressed");
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: Loading(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          await userPreferences.saveLoginUserInfo(textEmail, textPass);
          // ignore: use_build_context_synchronously
          context.go(RoutesName.homeScreen);
        },
      );
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to sign up${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(notExist);
    }
  }

  Future signIN(BuildContext context, {required String textEmail, required String textPass}) async {
    debugPrint("Button pressed");
    final notExist = bar.snack("Account doesn't exist", ColorManager.redColor);

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: Loading());
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          log("Seucces full logged in");
          await userPreferences.saveLoginUserInfo(textEmail, textPass);
          // ignore: use_build_context_synchronously
          context.go(RoutesName.homeScreen);
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(notExist);
    }
  }
}
