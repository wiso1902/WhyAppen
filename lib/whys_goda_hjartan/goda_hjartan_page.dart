import 'package:flutter/material.dart';
import '../addData_page/add_data.dart';
import '../viewData_page/view_data.dart';

class GodaHjartan extends StatelessWidget {
  const GodaHjartan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ViewData())),
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
}
