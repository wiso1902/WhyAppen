import 'package:flutter/material.dart';
import 'package:why_appen/whys_goda_hjartan/goda_hjartan_page.dart';
import 'package:why_appen/widgets/bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(
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
                            image: AssetImage('assets/images/goda_hjartan.jpg'),
                          ),
                        SizedBox(
                          height: 6
                        ),
                        Text(
                          "Why's Goda Hjärtan",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                            height: 6
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
}
