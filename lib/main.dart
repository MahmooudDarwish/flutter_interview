import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview/core/services/service_locator.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/views/person_dashboard.dart';
import 'package:flutter_interview/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonDashboard(),
    );
  }
}
