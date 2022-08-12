// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/screens/Login.dart';
import 'package:flutterproject/model/user_model.dart';

import 'ChangeProfile.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = FirebaseAuth.instance.currentUser;
  userModel loggedInUser = userModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      this.loggedInUser = userModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
          // ignore: prefer_const_literals_to_create_immutables
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 200,
            height: 200,
            child: loggedInUser.imageUrl == "blank"
                ? CircleAvatar(
                    child: Icon(Icons.account_circle_rounded, size: 120))
                : CircleAvatar(
                    backgroundImage: NetworkImage(loggedInUser.imageUrl),
                  ),
          ),
          SizedBox(height: 25),
          Row(
            children: [
              Icon(Icons.person),
              Text(
                "${loggedInUser.name}",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            children: [
              Icon(Icons.email),
              Text(
                "${loggedInUser.email}",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 25),
          ActionChip(
            backgroundColor: Colors.black,
            label: Container(
              height: 20,
              width: 120,
              child: Text(
                "Change Details",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeProfile()));
            },
          ),
          SizedBox(height: 25),
          ActionChip(
            backgroundColor: Colors.black,
            label: Container(
              height: 20,
              width: 60,
              child: Text(
                "Logout",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            onPressed: () {
              logout(context);
            },
          ),
        ]),
      )),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
