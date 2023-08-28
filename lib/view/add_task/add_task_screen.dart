import 'dart:developer';
import 'package:assignment_3/services/firebase_services.dart';
import 'package:flutter/material.dart';
import '../../widget/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/data_list _provider.dart';
class AddTaskScreen extends ConsumerStatefulWidget  {
  const AddTaskScreen({super.key, this.data});

  final UpdateData? data;

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final firebaseService = FirebaseServices();

  void onPressed(BuildContext context) async {
    if (_titleCtrl.text.trim() == "" ||
        _titleCtrl.text.trim().isEmpty ||
        _descriptionCtrl.text.trim() == "" ||
        _descriptionCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Required all filled"),
        ),
      );
    } else if (widget.data?.homeScreen ?? false) {
      log("inside");
      log(widget.data!.id.toString());
      await firebaseService.updateTodo(
        context,
        id: widget.data!.id,
        titleCtrl: _titleCtrl.text.trim(),
        descriptionCtrl: _descriptionCtrl.text.trim(),
        flag: widget.data!.taskStatus,
      );
      ref.read(todoList.notifier).fetchTodoList();
    } else {
      await firebaseService.addTodo(
        context,
        titleCtrl: _titleCtrl.text.trim(),
        descriptionCtrl: _descriptionCtrl.text.trim(),
      );
      _titleCtrl.clear();
      _descriptionCtrl.clear();
    }

  }

  void update() {
    if (widget.data?.homeScreen ?? false) {
      _titleCtrl.text = widget.data!.title;
      _descriptionCtrl.text = widget.data!.description;
    }
  }

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.data?.homeScreen ?? false ? const Text("Update Todo") : const Text("Add Todo"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                    onPressed: () {
                      onPressed(context);
                    },
                    child: const Text("Submit"),
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

class UpdateData {
  final String id;
  final String title;
  final String description;
  final bool homeScreen;
  final bool taskStatus;

  UpdateData({
    required this.id,
    required this.title,
    required this.description,
    required this.homeScreen,
    required this.taskStatus,
  });
}
