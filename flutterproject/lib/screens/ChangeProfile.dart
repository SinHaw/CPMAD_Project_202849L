// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/screens/Home.dart';
import 'package:flutterproject/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfile extends StatefulWidget {
  ChangeProfile({Key key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  String imageUrl;
  PickedFile image;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final NameEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
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
    final NameField = TextFormField(
        autofocus: false,
        controller: NameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value.isEmpty) {
            return ("Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          NameEditingController.text = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value.isEmpty) {
            return ("Please Enter Your Password");
          }
          // reg expression for email validation
          if (!RegExp(r'^.{6,}$').hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
          return null;
        },
        onSaved: (value) {
          NameEditingController.text = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final update = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            change();
          },
          child: Text(
            "Update",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    uploadImage();
                  },
                  child: imageUrl == null
                      ? CircleAvatar(
                          radius: 100.0,
                          child: Icon(Icons.photo_camera),
                        )
                      : CircleAvatar(
                          radius: 100.0,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                ),
                SizedBox(height: 20),
                NameField,
                SizedBox(height: 20),
                passwordField,
                SizedBox(height: 20),
                confirmPasswordField,
                SizedBox(height: 15),
                update,
              ]),
            ),
          ),
        ));
  }

  void change() async {
    if (_formKey.currentState.validate()) {
      user
          .updatePassword(passwordEditingController.text)
          .then((updateDetails()))
          .catchError((error) {
        Fluttertoast.showToast(msg: error.message);
      });
    }
  }

  updateDetails() async {
    //call firestore and user model
    //send value
    final _firebaseStorage = FirebaseStorage.instance;

    if (image != null) {
      var file = File(image.path);
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/' + NameEditingController.text)
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      setState(() {
        imageUrl = loggedInUser.imageUrl;
      });
    }
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    User user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.email = loggedInUser.email;
    UserModel.name = NameEditingController.text;
    UserModel.user_id = user.uid;
    UserModel.imageUrl = imageUrl;

    await firebase.collection("users").doc(user.uid).update(UserModel.toMap());
    Fluttertoast.showToast(msg: "Details Updated successfully");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage.ref().child('Temp').putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No Image Path Received');
    }
  }
}
