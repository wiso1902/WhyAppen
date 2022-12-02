import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../profile_page/edit_profile.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage()));
        },
        icon: Icon(
          FontAwesomeIcons.gear,
          size: 20,
        ),
      )
    ],
  );
}
