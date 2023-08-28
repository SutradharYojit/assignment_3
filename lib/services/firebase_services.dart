import 'dart:developer';
import 'package:assignment_3/routes/routes_name.dart';
import 'package:assignment_3/services/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../resources/color_manager.dart';
import '../widget/widget.dart';
class FirebaseServices {
  final auth = FirebaseAuth.instance.currentUser?.email;
  final db = FirebaseFirestore.instance;
  final bar = WarningBar();
  final userPreferences = UserPreferences();

  Future signUP(BuildContext context, {required String textEmail, required String textPass}) async {
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
          context.go(RoutesName.dashboardScreen);
        },
      );
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      final notExist = bar.snack(e.message.toString(), ColorManager.redColor);

      debugPrint("Failed to sign up${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(notExist);
      Navigator.pop(context);
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
          context.go(RoutesName.dashboardScreen);
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(notExist);
    }
  }

  Future<void> addTodo(BuildContext context, {required String titleCtrl, required String descriptionCtrl}) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Loading();
      },
    );
    final userData = <String, dynamic>{"title": titleCtrl, "description": descriptionCtrl, "flag": false};
    db.collection(auth!).doc().set(userData).then(
      (value) {
        log("Add Success fully");
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Add Successfully")));
        Navigator.pop(context);
      },
    );
  }

  Future<void> updateTodo(BuildContext context,
      {required String id, required String titleCtrl, required String descriptionCtrl, required bool flag}) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Loading();
      },
    );
    final userData = <String, dynamic>{
      "title": titleCtrl,
      "description": descriptionCtrl,
      "flag": flag,
    };
    await db.collection(auth!).doc(id).update(userData).then(
      (value) {
        log("update Success fully");
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Data Update Successfully"),
          ),
        );
        Navigator.pop(context);
      },
    );
  }

  Future<void> markTodo(BuildContext context, {required String id, required bool value}) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Loading();
      },
    );

    await db.collection(auth!).doc(id).update({"flag": value}).then(
      (value) {
        log("Success update: ");
        Navigator.pop(context);
      },
    );
  }

  Future<void> deleteTodo(BuildContext context, {required String id}) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: Loading());
      },
    );
    await db.collection(auth!).doc(id).delete().then(
      (value) {
        Navigator.pop(context);
      },
    );
  }
}
