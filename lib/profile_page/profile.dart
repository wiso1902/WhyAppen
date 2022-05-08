import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:why_appen/widgets/appbar_widget.dart';
import 'package:why_appen/profile_page/edit_profile.dart';
import 'package:why_appen/profile_page/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  CollectionReference beerBurgers = FirebaseFirestore.instance.collection('beerBurger');
  String userID = "";
  String imagePath = "https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/why-avatar.png?alt=media&token=47dd9052-b409-4254-87d4-53f1ded04869";
  String name = "Test";
  late bool okBeer = true;
  late String beer = "0";
  late String burger = "0";
  late String tr = "0";
  late String pengar = "0";

  fetchUserID() async {
    User getUser = FirebaseAuth.instance.currentUser!;
    userID = getUser.uid;
  }

  getTr() async {
    int tr1;
    fetchUserID();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('top').doc(userID).get();
    tr1 = ds.get('totalTr');
    setState(() {
      tr = tr1.toString();
      pengar = (tr1 * 20).toString();
    });
  }


  getImage() async {
    fetchUserID();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    setState(() {
      imagePath = ds.get('imagePath');
      name = ds.get('name');
    });
  }

  getBurger() async {
    if (okBeer == true){
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('beerBurger').doc(userID).get();
        setState(() {
          burger = ds.get('burger').toString();
        });
    } else if (okBeer == false){
        setState(() {
          burger = '0';
        });
    }
  }

  getOkBeer() async {
    fetchUserID();
    FirebaseFirestore.instance.collection('beerBurger').doc(userID).get().then((onExists) {
      onExists.exists ? okBeer = true : okBeer = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserID();
    getTr();
    getOkBeer();
    getImage();
    getBeer();
    getBurger();

  }

  getBeer() async {
    if (okBeer == true){
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('beerBurger').doc(userID).get();
      setState(() {
        beer = ds.get('beer').toString();
      });

    } else if (okBeer == false){
      setState(() {
        beer = '0';
      });

    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imagePath,
            onClicked: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(name),
          const SizedBox(height: 24),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButton1(
                  context,
                  '1',
                  Icon(
                    FontAwesomeIcons.trophy,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                ),
                buildDevider(),
                buildButton2(
                  context,
                  burger,
                  Icon(
                    FontAwesomeIcons.burger,
                    size: 20,
                  ),
                ),
                buildDevider(),
                buildButton3(
                  context,
                  beer,
                  Icon(
                    FontAwesomeIcons.beerMugEmpty,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Träningar: $tr',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Insamlat: $pengar kr',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildName(name) => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildDevider() => Container(
    height: 35,
    child: VerticalDivider(),
  );
  Widget buildButton1(BuildContext context, String value, Icon icon) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 2),
            Icon(
              FontAwesomeIcons.trophy,
              color: Colors.orangeAccent,
              size: 20,
            ),
          ],
        ),
      );

  Widget buildButton2(BuildContext context, String value, Icon icon) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 2),
            Icon(
              FontAwesomeIcons.burger,
              color: Colors.orangeAccent,
              size: 20,
            ),
          ],
        ),
      );

  Widget buildButton3(BuildContext context, String value, Icon icon) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 10),
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 2),
            Icon(
              FontAwesomeIcons.beerMugEmpty,
              color: Colors.orangeAccent,
              size: 20,
            ),
          ],
        ),
      );
}