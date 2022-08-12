import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/screens/BusStop.dart';
import 'package:flutterproject/screens/Home.dart';
import 'package:flutterproject/screens/Login.dart';
import 'package:flutterproject/screens/Registration.dart';
import 'package:flutterproject/screens/map.dart';
import 'package:flutterproject/screens/walkingTrail.dart';
import 'package:flutterproject/screens/walkingTrailDetails.dart';
import 'package:flutterproject/screens/walkingTrailSearch.dart';
import 'NearestBusStop.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: wtDetails(),
    );
  }
}
