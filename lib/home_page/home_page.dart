import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:why_appen/whys_goda_hjartan/goda_hjartan_page.dart';
import 'package:why_appen/widgets/bottom_nav.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Why Menyn",
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(34),
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
          crossAxisCount: 2,
          children: [
            Container(
              child: Hero(
                tag: 'godaHjartan',
                child: Material(
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 8,
                  color: Colors.orange,
                  child: InkWell(
                    splashColor: Colors.orange,
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GodaHjartan())),
                    child: Column(
                      children: [
                        Ink.image(
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/heart.png'),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Why's Goda Hjärtan",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Hero(
                tag: 'whyFoldet',
                child: Material(
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 8,
                  color: Colors.orange,
                  child: InkWell(
                    splashColor: Colors.orange,
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Column(
                      children: [
                        Ink.image(
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/why-loggan.png'),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Why Flödet",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void showAlertDialog(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Kommer snart'),
      content: const Text('Ett exempel på att ni kan lägga till fler funktioner i appen'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );

}
