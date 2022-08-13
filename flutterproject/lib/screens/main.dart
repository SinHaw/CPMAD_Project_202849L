import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterproject/screens/BusStop.dart';
import 'package:flutterproject/screens/Home.dart';
import 'package:flutterproject/screens/Login.dart';
import 'package:flutterproject/screens/Registration.dart';
import 'package:flutterproject/screens/map.dart';
import 'package:flutterproject/screens/routeMap.dart';
import 'package:flutterproject/screens/routeSearch.dart';
import 'package:flutterproject/screens/walkingTrail.dart';
import 'package:flutterproject/screens/walkingTrailDetails.dart';
import 'package:flutterproject/screens/walkingTrailSearch.dart';
import 'NearestBusStop.dart';

bool signedInUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      print("not signed in");
      signedInUser = false;
    } else {
      signedInUser = true;
    }
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  MyApp({Key key}) : super(key: key);
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: signedInUser == false ? LoginScreen() : Home(),
    );
  }
}
