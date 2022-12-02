import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:why_appen/profile_page/profile.dart';

import '../auth_service.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[100],
      unselectedItemColor: Colors.orangeAccent,
      items: const[
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 20,
          ),
          label: 'Logga ut',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.imagePortrait,
            color: Colors.orangeAccent,
            size: 20,
          ),
          label: 'Profil',
        ),
      ],
      onTap: (int idx){
        switch (idx) {
          case 0:
            context.read<AuthenticationService>().signOut();
            break;

          case 1:
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
            break;
        }
      },
    );
  }
}
