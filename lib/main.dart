import 'package:flutter/material.dart';
import 'package:test_app/app/app.dart';
import 'package:test_app/services/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

