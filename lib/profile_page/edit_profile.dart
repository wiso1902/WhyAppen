import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:why_appen/profile_page/edit_appbar.dart';
import 'package:why_appen/profile_page/textfeild_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name ="";
  String userID = "";

  fetchUserID() async {
    User getUser = FirebaseAuth.instance.currentUser!;
    userID = getUser.uid;
  }

  getName() async {
    fetchUserID();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    setState(() {
      name = ds.get('name');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            TextFieldWidget(
              label: 'Namn',
              text: name,
              onChanged:(name) {},
            ),
          ],
        ),
      );

}
