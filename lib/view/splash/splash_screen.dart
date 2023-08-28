import 'package:assignment_3/routes/routes_name.dart';
import 'package:assignment_3/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userPreferences = UserPreferences();
  @override
  void initState() {
    super.initState();
    userPreferences.getUserInfo();
    navigation();
  }

  void navigation() {
    Duration duration = const Duration(seconds: 3);
    Future.delayed(
      duration,
      () {
        if (userPreferences.email != null &&
            userPreferences.pass != null &&
            userPreferences.email!.isNotEmpty &&
            userPreferences.pass!.isNotEmpty) {
          context.go(RoutesName.dashboardScreen);
        } else {
          context.go(RoutesName.loginScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TODO List",
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: SpinKitFoldingCube(
                    color: Colors.black,
                    size: 45,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
