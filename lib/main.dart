import 'package:flutter/material.dart';
import 'package:my_blog/controller/homeController.dart';
import 'package:my_blog/controller/loginController.dart';
import 'package:my_blog/controller/registrationController.dart';
import 'package:my_blog/routes/routes.dart';
import 'package:my_blog/routes/routesName.dart';
import 'package:provider/provider.dart';

import 'controller/themeColorMode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (_) => ThemeColorProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationController()),
        ChangeNotifierProvider(create: (_) => ProductController()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<ThemeColorProvider>(context);
        return MaterialApp(
          themeMode: themeChanger.themeMode,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.grey,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.cyan,
            primaryColor: Colors.yellowAccent,
            iconTheme: const IconThemeData(color: Colors.white),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black54),
          ),
          initialRoute: RoutesName.login,
          onGenerateRoute: Routes.generateRoute,
        );
      }),
    );
  }
}
