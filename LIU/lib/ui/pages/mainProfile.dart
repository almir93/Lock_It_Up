import 'dart:io';

import 'package:Lock_It_Up/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditProfile extends StatefulWidget {
  final String activeUserID;
  EditProfile(this.activeUserID);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User activeUser;
  Timestamp age;
  bool isLoading = true;
  Future<void> getUserData() async {
    final result = await Firestore.instance
        .collection("users")
        .document(widget.activeUserID)
        .get();
    activeUser = User(
      uid: result.documentID,
      name: result["name"],
      location: result.data["location"],
      age: result.data["age"],
      gender: result.data["gender"],
      interestedIn: result.data["interestedIn"],
      photo: result.data["photoURL"],
    );
  }

  @override
  void initState() {
    getUserData().then((value) {
      setState(() {
        isLoading = false;
      });
      print("isLoading is false");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                ),

                // name
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      hintText: activeUser.name,
                      labelText: "Name",
                      alignLabelWithHint: true,
                    ),
                    onChanged: (val) {
                      activeUser.name = val;
                    },
                  ),
                ),

                // image
                Row(
                  children: [
                    FlatButton(
                      child: Text(
                        "Upload Image",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.09),
                      ),
                      onPressed: () async {
                        File toUpload = await FilePicker.getFile(
                          type: FileType.image,
                        );
                        FirebaseStorage _storage = FirebaseStorage.instance;
                        StorageReference reference = _storage
                            .ref()
                            .child(DateTime.now().toIso8601String());
                        StorageUploadTask uploadTask =
                            reference.putFile(toUpload);
                        var uploaded = await uploadTask.onComplete;
                        final url = uploaded.uploadSessionUri;
                        activeUser.photo = url.toString();
                      },
                    ),
                  ],
                ),

                // date of birth
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime(DateTime.now().year - 19, 1, 1),
                      onConfirm: (date) {
                        age = Timestamp.fromDate(date);
                        setState(() {
                          age = Timestamp.fromDate(date);
                        });
                      },
                    );
                  },
                  child: Text(
                    "Enter Birthday",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.09),
                  ),
                ),
                // Gender
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      hintText: activeUser.gender,
                      labelText: "Gander",
                      alignLabelWithHint: true,
                    ),
                    onChanged: (val) {
                      activeUser.gender = val;
                    },
                  ),
                ),

                // interested in
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      hintText: activeUser.interestedIn,
                      labelText: "Interested In",
                      alignLabelWithHint: true,
                    ),
                    onChanged: (val) {
                      activeUser.interestedIn = val;
                    },
                  ),
                ),

                RaisedButton(onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  Firestore.instance.collection("users").document(activeUser.uid).setData({
                    "uid" : activeUser.uid,
                    "gender":activeUser.gender,
                    "age": activeUser.age,
                    "interestedIn" : activeUser.interestedIn,
                    "name": activeUser.name,
                    "photoUrl":activeUser.photo,
                    "location":activeUser.location,
                  }).then((value){
                    Navigator.of(context).pop();
                  });
                }, child: Text("Save Changes"),),
              ],
            ),
    );
  }
}
