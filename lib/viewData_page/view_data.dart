import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:why_appen/widgets/palatte.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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

  getImage(String userID) async {
    String image;
    DocumentSnapshot getImagePath =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    image = getImagePath.get('imagePath');
    return image;
  }

  getTotal() async {
    int totalInt;
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('total').doc('total').get();
    totalInt = ds.get('total');
    setState(() {
      total = (totalInt * 20).toString();
    });
  }

  CollectionReference val = FirebaseFirestore.instance.collection('val');
  late FixedExtentScrollController scrollController;
  late List items = ['Välj träning'];
  var index = 0;

  fetchItems() async {
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('val').doc('items').get();
    items = ds.get('items');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
    getOk();
    getTotala();
    getUserScore();
    fetchItems();
    fetchUserID();
    getNameAndImage();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Insamlat: $total Kr')),
      ),
      body: isChecked ? buildStreamBuilderTop() : buildStreamBuilderDate(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.personRunning,
                color: Colors.orangeAccent,
                size: 20,
              ),
              label: "Lägg till träning"),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.arrowUp,
                color: Colors.orangeAccent,
                size: 20,
              ),
              label: "Topplista"),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.plus,
                color: Colors.orangeAccent,
                size: 20,
              ),
              label: "Saknas en träning?")
        ],
        onTap: (int idx) {
          switch (idx) {
            case 0:
              showAlertDialog(context);
              break;
            case 1:
              setState(() => isChecked = !isChecked);
              break;
            case 2:
              showCreateTr(context);
              break;
          }
        },
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilderTop() {
    return StreamBuilder<QuerySnapshot>(
      stream: trViewTop,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Nått gick snett');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Datan hämtas');
        }
        final data = snapshot.requireData;
        return AnimationLimiter(
          child: ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot user = snapshot.data!.docs[index];
                String imagePath = user['imagePath'];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: SlideAnimation(
                    verticalOffset: 44,
                    child: FadeInAnimation(
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(imagePath)),
                          title: Text('${data.docs[index]['name']}'),
                          subtitle:
                              Text('Träningar ${data.docs[index]['totalTr']}'),
                          trailing: Text(
                            ' + ${data.docs[index]['totalTr'] * 20} Kr',
                            style: TextStyle(color: Colors.green),
                          ),
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

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilderDate() {
    return StreamBuilder<QuerySnapshot>(
      stream: trViewDate,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Nått gick snett');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Datan hämtas');
        }
        final data = snapshot.requireData;
        return AnimationLimiter(
          child: ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot user = snapshot.data!.docs[index];
                String imagePath = user['imagePath'];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: SlideAnimation(
                    verticalOffset: 44,
                    child: FadeInAnimation(
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(imagePath)),
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

  DateTime? date1;
  DateTime dateTime = DateTime.now();

  String getText() {
    if (dateTime == null) {
      return 'Välj Datum';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  Widget buildPickerDate() => SizedBox(
        height: 350,
        child: CupertinoDatePicker(
          minimumYear: DateTime.now().year,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  Widget buildPickerTr() => SizedBox(
        height: 350,
        child: CupertinoPicker(
            scrollController: scrollController,
            itemExtent: 64,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: CupertinoColors.activeOrange.withOpacity(0.2),
            ),
            onSelectedItemChanged: (index) {
              setState(() => this.index = index);
            },
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Center(
                  child: Text(
                item,
                style: TextStyle(fontSize: 32),
              ));
            })),
      );

  showAlertDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setState) {
            return CupertinoAlertDialog(
              title: Text("Lägg till träning", style: kText),
              actions: [
                CupertinoButton(
                    child: Text(items[index],
                        style: const TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      scrollController.dispose();
                      scrollController =
                          FixedExtentScrollController(initialItem: index);
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                                actions: [buildPickerTr()],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() => items[index]);
                                  },
                                ),
                              ));
                    }),
                CupertinoButton(
                    child: Text(getText(),
                        style: const TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      dateTime = DateTime.now();
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                                actions: [buildPickerDate()],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() => getText());
                                  },
                                ),
                              ));
                    }),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    setDataTr();
                    setDataTop();
                  },
                  child: Text('OK', style: kText),
                ),
              ],
            );
          },
        ),
      );

  TextEditingController trController = TextEditingController();
  showCreateTr(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(
              "Lägg till en ny träning",
              style: kText,
            ),
            actions: [
              Column(
                children: [
                  CupertinoTextField(
                    controller: trController,
                    style: kBodytext,
                    textAlign: TextAlign.center,
                    placeholder: "Ny träning",
                    placeholderStyle: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    child: Text(
                      "Lägg till",
                      style: kText,
                    ),
                    onPressed: () {
                      Addtr();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ));

  Addtr() async {
    String test = trController.text;
    items.add(trController.text);
    var collection = FirebaseFirestore.instance.collection('val');
    collection
        .doc('items') // <-- Document ID
        .set({'items': FieldValue.arrayUnion(items)}) // <-- Add data
        .then(
          (_) => AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: true,
            title: 'Ny träning tillagd',
            desc:
            "Nya träningen $test är tillagd",
            btnOkOnPress: () {
              debugPrint('OnClcik');
            },
            btnOkIcon: Icons.check_circle,
            onDismissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show()
        )
        .catchError((error) => print('Add failed: $error'));
  }

  String makeDateInt() {
    if (dateTime == null) {
      return 'error';
    } else {
      return DateFormat('yyyyMMdd').format(dateTime);
    }
  }

  String name = "";
  String imagePath = "";
  getNameAndImage() async {
    fetchUserID();
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    name = ds.get('name');
    imagePath = ds.get('imagePath');
  }

  String userID = "";
  fetchUserID() async {
    User getUser = FirebaseAuth.instance.currentUser!;
    userID = getUser.uid;
  }

  CollectionReference tr = FirebaseFirestore.instance.collection('tr');

  setDataTr() {
    String pop = items[index];
    String makeDateshow(){
      if(dateTime == null){
        return 'error';
      } else {
        return DateFormat('yyyy-MM-dd').format(dateTime!);
      }
    }
    String dateShow = makeDateshow();
    late String dateString = makeDateInt();
    late var dateInt = int.parse(dateString);
    tr
        .add({
          'name': name,
          'träning': items[index],
          'datum': getText(),
          'tid': dateInt,
          'imagePath': imagePath,
          'userID': userID,
        })
        .then(
          (value) => AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: true,
            title: 'Träningen tillagd',
            desc:
            "Din träning $pop $dateShow är tillagd",
            btnOkOnPress: () {
              debugPrint('OnClcik');
            },
            btnOkIcon: Icons.check_circle,
            onDismissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show()
        )
        .catchError(
          (error) => print('Add failed: $error')
        );
  }

  late int totala;
  getTotala() async {
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('total').doc('total').get();
    totala = ds.get('total');
  }

  getUserScore() async {
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('top').doc(userID).get();
    totalTr1 = ds.get('totalTr');
    return totalTr1;
  }

  late bool ok;
  getOk() async {
    fetchUserID();
    FirebaseFirestore.instance
        .collection('top')
        .doc(userID)
        .get()
        .then((onExists) {
      onExists.exists ? ok = true : ok = false;
    });
  }

  CollectionReference top = FirebaseFirestore.instance.collection('top');
  CollectionReference totaltr = FirebaseFirestore.instance.collection('total');
  int totalTr = 1;
  int totalTr1 = 0;

  setDataTop() async {
    getOk();
    getUserScore();
    getTotala();
    if (ok == false) {
      top
          .doc(userID)
          .set({
            'totalTr': totalTr,
            'name': name,
            'imagePath': imagePath,
            'userID': userID,
          })
          .then((value) => print('Top added'))
          .catchError((error) => Fluttertoast.showToast(
              msg: 'error $error',
              textColor: Colors.orange,
              backgroundColor: Colors.white));
    } else if (ok == true) {
      top
          .doc(userID)
          .update({
            'totalTr': totalTr1 + 1,
            'name': name,
            'imagePath': imagePath,
            'userID': userID,
          })
          .then((value) => print('Top update'))
          .catchError((error) => Fluttertoast.showToast(
              msg: 'error $error',
              textColor: Colors.orange,
              backgroundColor: Colors.white));
    }

    totaltr
        .doc('total')
        .update({
          'total': totala + 1,
        })
        .then((value) => print('Top update'))
        .catchError((error) => Fluttertoast.showToast(
            msg: 'error $error',
            textColor: Colors.orange,
            backgroundColor: Colors.white));
  }
}
