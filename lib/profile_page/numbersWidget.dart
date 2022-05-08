
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumbersWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
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
              '1',
              Icon(
                FontAwesomeIcons.burger,
                size: 20,
              ),
            ),
            buildDevider(),
            buildButton3(
              context,
              '1',
              Icon(
                FontAwesomeIcons.beerMugEmpty,
                color: Colors.orangeAccent,
                size: 20,
              ),
            ),
          ],
        ),
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
