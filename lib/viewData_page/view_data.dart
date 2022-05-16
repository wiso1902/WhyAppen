import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  final Stream<QuerySnapshot> trViewDate = FirebaseFirestore.instance
      .collection('tr')
      .orderBy('tid', descending: true)
      .snapshots();

  final Stream<QuerySnapshot> trViewTop = FirebaseFirestore.instance
      .collection('top')
      .orderBy('totalTr', descending: true)
      .snapshots();


  bool isChecked = false;
  late String total = "0";

  Future getImage(String userID) async {
    DocumentSnapshot getImagePath = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    return getImagePath.get('imagePath');
  }

  getTotal() async {
    int totalInt;
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('total')
        .doc('total')
        .get();
    totalInt = ds.get('total');
    setState(() {
      total = (totalInt * 20).toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() => isChecked = !isChecked);
                  getTotal();
                },
                icon: Icon(FontAwesomeIcons.arrowUpWideShort))
          ],
          title: Center(child: Text('Insamlat: $total Kr')),
        ),
        body: isChecked ? buildStreamBuilderTop() : buildStreamBuilderDate(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilderTop() {
    return StreamBuilder<QuerySnapshot>(
      stream: trViewTop,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Nått gick snett');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Datan hämtas');
        }
        final data = snapshot.requireData;
        return AnimationLimiter(
          child: ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot user = snapshot.data!.docs[index];
                  String userID = user['userID'];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(seconds: 1),
                    child: SlideAnimation(
                      verticalOffset: 44,
                      child: FadeInAnimation(
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/why-avatar.png?alt=media&token=47dd9052-b409-4254-87d4-53f1ded04869')),
                            title: Text('${data.docs[index]['name']}'),
                            subtitle: Text('Träningar ${data.docs[index]['totalTr']}'),
                            trailing: Text(' + ${data.docs[index]['totalTr'] * 20 } Kr',
                              style: TextStyle(color: Colors.green),),
                          ),
                        ),
                      ),
                    ),
                  );
                }
          ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilderDate() {
    return StreamBuilder<QuerySnapshot>(
      stream: trViewDate,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Nått gick snett');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Datan hämtas');
        }
        final data = snapshot.requireData;
        return AnimationLimiter(
          child: ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot user = snapshot.data!.docs[index];
                String userID = user['userID'];
                getImage(userID);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: SlideAnimation(
                    verticalOffset: 44,
                    child: FadeInAnimation(
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/why-avatar.png?alt=media&token=47dd9052-b409-4254-87d4-53f1ded04869')),
                          title: Text('${data.docs[index]['name']}'),
                          subtitle: Text('${data.docs[index]['träning']}'),
                          trailing: Text('${data.docs[index]['datum']}'),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

}
