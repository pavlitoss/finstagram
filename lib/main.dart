import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/login_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // ignore: prefer_const_constructors
      options: FirebaseOptions(
    apiKey: 'AIzaSyBimrFeCx0YhOZgGNIcPxO3rqgHZtivcUo',
    appId: '1:888618262275:android:e31ab042d60ae3e6e51336',
    messagingSenderId: 'sendid',
    projectId: 'finstagram-c7ba9',
    storageBucket: 'finstagram-c7ba9.appspot.com',
  ));
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finstagram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "login",
      routes: {
        "register": (context) => RegisterPage(),
        "login": (context) => LoginPage(),
        "home": (context) => HomePage(),
      },
    );
  }
}
