import 'package:assignment_3/routes/routes_name.dart';
import 'package:assignment_3/services/firebase_services.dart';
import 'package:assignment_3/view/add_task/add_task_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import '../../widget/widget.dart';
import 'data_list _provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final auth = FirebaseAuth.instance.currentUser?.email;
  final db = FirebaseFirestore.instance;
  final firebaseServices = FirebaseServices();

  @override
  void initState() {
    super.initState();
    ref.read(todoList.notifier).fetchTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: RefreshIndicator(
            onRefresh: ref.read(todoList.notifier).fetchTodoList,
            child: Consumer(
              builder: (context, ref, child) {
                final data = ref.watch(todoList);
                final loading = ref.read(todoList.notifier).loading;
                return loading
                    ? const Center(
                        child: SpinKitFoldingCube(
                          color: Colors.black,
                          size: 45,
                        ),
                      )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          data.isEmpty
                              ? Center(child: const Text("No Todo list"))
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        onDismissed: (direction) async {
                                          firebaseServices.deleteTodo(context, id: data[index].id!);
                                          ref.read(todoList.notifier).remove(data[index]);
                                        },
                                        key: UniqueKey(),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.push(
                                              RoutesName.addTaskScreen,
                                              extra: UpdateData(
                                                  id: data[index].id!,
                                                  title: data[index].title!,
                                                  description: data[index].description!,
                                                  taskStatus: data[index].flag!,
                                                  homeScreen: true),
                                            );
                                          },
                                          child: Card(
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    constraints: const BoxConstraints(
                                                      maxWidth: 270,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        TextRich(title: "Title\t:", description: data[index].title!),
                                                        TextRich(
                                                          title: "Description\t:",
                                                          description: data[index].description!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () async {
                                                          firebaseServices.deleteTodo(context, id: data[index].id!);
                                                          ref.read(todoList.notifier).remove(data[index]);
                                                        },
                                                        icon: const Icon(Icons.delete_outline_rounded),
                                                      ),
                                                      Checkbox(
                                                        value: data[index].flag,
                                                        onChanged: (value) async {
                                                          setState(() {});
                                                          data[index].flag = value;
                                                          firebaseServices.markTodo(context,
                                                              id: data[index].id!, value: value!);
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
