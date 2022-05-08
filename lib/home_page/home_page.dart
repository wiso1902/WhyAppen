import 'package:flutter/material.dart';
import 'package:why_appen/widgets/bottom_nav.dart';
import 'package:why_appen/home_page/catagory_item.dart';
import 'package:why_appen/home_page/test_button.dart';

import '../addData_page/add_data.dart';
import '../viewData_page/view_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddData())),
                child: Text(
                  'Lägg till träning',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ViewData())),
                child: Text(
                  'Se träningar',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
