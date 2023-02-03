import 'package:flutter/material.dart';
import 'package:why_appen/viewData_page/view_data.dart';
import 'package:why_appen/why_flodet/add_post.dart';
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
              child: Material(
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 8,
                color: Colors.orange,
                child: InkWell(
                  splashColor: Colors.orange,
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewData())),
                  child: Ink.image(
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/heart.png'),
                  ),
                ),
              ),
            ),
            Container(
              child: Material(
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 8,
                color: Colors.orange,
                child: InkWell(
                  splashColor: Colors.orange,
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddPost())),
                  child: Ink.image(
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/why-loggan.png'),
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