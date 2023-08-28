import 'package:assignment_3/routes/routes_name.dart';
import 'package:go_router/go_router.dart';
import '../view/view.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.splashScreen,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: RoutesName.loginScreen,
      builder: (context, state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: RoutesName.signupScreen,
      builder: (context, state) {
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: RoutesName.dashboardScreen,
      builder: (context, state) {
        return DashBoardScreen();
      },
    ),
    GoRoute(
      path: RoutesName.homeScreen,
      builder: (context, state) {
        return const MyHomePage();
      },
    ),
    GoRoute(
      path: RoutesName.addTaskScreen,
      builder: (context, state) {
        return AddTaskScreen(data: state.extra as UpdateData);
      },
    ),
  ],
);
