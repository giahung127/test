import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'Screens/Home/home_screen.dart';
import 'constant.dart';
import 'Screens/Initial Screens/Welcome/welcome_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/DeviceControl/components/provider.dart';
//firebase libs
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // Providers
      ChangeNotifierProvider<EventProvider>(
        create: (context) => EventProvider(),
      ),
      ChangeNotifierProvider<Device>(
        create: (context) => Device(),
      ),
    ],
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Don't display banner when debugging
      title: 'Smart Farm',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
