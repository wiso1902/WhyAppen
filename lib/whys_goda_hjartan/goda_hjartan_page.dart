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
    fetchUserDoc();
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
                      image: AssetImage('assets/images/heart.png'),
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
                  if(docExists == false) {
                    showAlertDialog(context);
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

  void showAlertDialog(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Skapa profil'),
      content: const Text('Innan du börjar spara träningar behöver du skapa en profil och spara ett namn, gå till startsidan och tryck på profil => kugghjulet'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );

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
