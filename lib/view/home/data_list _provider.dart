import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/data_model.dart';

final todoList = AutoDisposeStateNotifierProvider<TodoDataList, List<DataModel>>((ref) => TodoDataList());

class TodoDataList extends StateNotifier<List<DataModel>> {
  TodoDataList() : super([]);

  bool loading = true;
  final auth = FirebaseAuth.instance.currentUser?.email;
  final db = FirebaseFirestore.instance;

  Future<void> fetchTodoList() async {
    state.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection(auth!).get();
    state.addAll(snapshot.docs.map((docSnapshot) => DataModel.fromFirestore(docSnapshot)).toList());
    loading = false;
    log(state.length.toString());
    state = [...state];
  }


  void remove(DataModel data){
    state.remove(data);
    state=[...state];
  }
}
