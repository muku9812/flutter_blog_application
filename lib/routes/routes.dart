import 'package:flutter/material.dart';
import 'package:my_blog/routes/routesName.dart';
import 'package:my_blog/view/loginView.dart';
import 'package:my_blog/view/postView.dart';
import 'package:my_blog/view/registerView.dart';

import '../view/darkTheme.dart';
import '../view/homeView.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.post:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PostView());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RoutesName.screenMode:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DarkThemeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined."),
            ),
          );
        });
    }
  }
}
