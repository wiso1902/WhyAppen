import 'package:flutter/material.dart';
import '../addData_page/add_data.dart';
import '../viewData_page/view_data.dart';

class GodaHjartan extends StatelessWidget {
  const GodaHjartan({Key? key}) : super(key: key);

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
                    Navigator.of(context).push(_createRoute1());
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
}
