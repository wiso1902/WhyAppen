import 'package:flutter/material.dart';

import '../addData_page/add_data.dart';
import '../profile_page/profile.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  CategoryItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Center(
          child: InkWell(
            onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddData()));
          },
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]
                )
            ),
          ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
