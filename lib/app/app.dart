import 'package:flutter/material.dart';
import 'package:test_app/ui/auth/registeration_view.dart';
import 'package:test_app/ui/auth/sign_in_view.dart';
import 'package:test_app/ui/auth/sign_up_view.dart';
import 'package:test_app/ui/dashboard/dashboard_view.dart';
import 'package:test_app/services/locator.dart';
import 'package:test_app/services/sharedprefs_services.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();
  bool isLogged = false;
  bool isSigned = false;

  @override
  void initState() {
    isLogged = _sharedPrefsService.read(SharedPrefsService.IS_LOGGED) ?? false;
    isSigned = _sharedPrefsService.read(SharedPrefsService.IS_SIGNED) ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => (isLogged && isSigned)
            ? DashboardView()
            : RegistrationView(), // Replace with your initial widget if needed
        '/dashboard': (context) => DashboardView(),
        '/registration': (context) => RegistrationView(),
        '/signin': (context) => SignInView(),
        '/signup': (context) => SignUpView(),
      },
    );
  }
}
