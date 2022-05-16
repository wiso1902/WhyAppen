import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:why_appen/auth_service.dart';
import 'package:why_appen/home_page/home_page.dart';
import 'package:why_appen/profile_page/edit_profile.dart';
import 'package:why_appen/sign_in_page/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'auth_service.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          dividerColor: Colors.black,
          primaryColor: Colors.orangeAccent,
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  AuthenticationWrapper({Key? key}) : super(key: key);

  bool docExists = false;

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
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    fetchUserDoc();

    if (firebaseUser != null) {

        if(docExists = false) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage()));
        }
        return const HomePage();

    }
      return SignInPage();
  }
}