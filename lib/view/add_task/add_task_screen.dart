import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final auth = FirebaseAuth.instance.currentUser?.email;
  final db = FirebaseFirestore.instance;

  Future<void> addTodo() async {
    final userData = <String, dynamic>{
      "title": _titleCtrl.text.trim(),
      "description": _descriptionCtrl.text.trim(),
      "flag": false
      // "Password": textPassCtrl.text.trim()
    };
    db.collection(auth!).doc().set(userData).then(
      (value) {
        log("Add Success fully");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              PrimaryTextFilled(
                controller: _titleCtrl,
                hintText: "Title",
                labelText: "Title",
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryTextFilled(
                controller: _descriptionCtrl,
                hintText: "Write description",
                labelText: "Description",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await addTodo();
                    _titleCtrl.clear();
                    _descriptionCtrl.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
