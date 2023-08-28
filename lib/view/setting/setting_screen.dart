import 'package:assignment_3/view/setting/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../resources/color_manager.dart';
import '../../services/user_preferences.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final auth = FirebaseAuth.instance.currentUser?.email;
  bool light = true;
  final userPreferences = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          auth.toString(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {},
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 22),
                ),
                trailing: Consumer(
                  builder: (context, ref, child) {
                    final dark=ref.watch(darkMode);
                    return Switch(
                      value: dark,
                      activeColor: Colors.purpleAccent,
                      onChanged: (bool data) {
                        ref.read(darkMode.notifier).update((state) => data);
                      },
                    );
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  buildShowDialog(context);
                },
                title: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: ColorManager.whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Are you sure, you want to log out?",
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        fixedSize: const Size(80, 20),
                        backgroundColor: ColorManager.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        userPreferences.logOutsetData(context);
                      },
                      child: Text(
                        "Log out",
                        style: TextStyle(fontSize: 14, color: ColorManager.whiteColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        fixedSize: const Size(70, 20),
                        backgroundColor: ColorManager.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 14, color: ColorManager.whiteColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
