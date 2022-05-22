import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../addData_page/add_data.dart';
import '../profile_page/edit_profile.dart';
import '../viewData_page/view_data.dart';


class GodaHjartan extends StatefulWidget {
  GodaHjartan({Key? key}) : super(key: key);

  @override
  State<GodaHjartan> createState() => _GodaHjartanState();
}

class _GodaHjartanState extends State<GodaHjartan> {
  bool docExists = true;

  fetchUserDoc() async {
    String userID;
    User getUser = FirebaseAuth.instance.currentUser!;
    userID = getUser.uid;

    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(userID).get();

    if (ds.exists) {
      docExists = true;
    } else {
      docExists = false;
    }

  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Why's goda hjärtan", style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Hero(
                tag: 'godaHjartan',
                child: Material(
                    borderRadius: BorderRadius.circular(28),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 8,
                    child: const Image(
                      image: AssetImage('assets/images/goda_hjartan.jpg'),
                      width: 250,
                      height: 200,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(height: 50),
            Material(
              borderRadius: BorderRadius.circular(18),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 8,
              color: Colors.orange,
              child: TextButton(
                onPressed: (){
                  fetchUserDoc();
                  if(docExists == false) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage()));
                    Fluttertoast.showToast(msg: 'Spara ett namn först',toastLength: Toast.LENGTH_LONG, textColor: Colors.orange, backgroundColor: Colors.white);
                  } else {
                    Navigator.of(context).push(_createRoute1());
                  }
                },
                child: const Text(
                  'Lägg till träning',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
            ),
            SizedBox(height: 50),
            Material(
              borderRadius: BorderRadius.circular(18),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 8,
              color: Colors.orange,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: const Text(
                  'Se alla träningar',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ViewData(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRoute1() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddData(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
