import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:why_appen/home_page/home_page.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  CollectionReference tr = FirebaseFirestore.instance.collection('tr');
  CollectionReference top = FirebaseFirestore.instance.collection('top');
  CollectionReference total = FirebaseFirestore.instance.collection('total');
  CollectionReference val = FirebaseFirestore.instance.collection('val');
  final FirebaseAuth auth = FirebaseAuth.instance;

  late DatabaseReference databaseReference;
  late FixedExtentScrollController scrollController;
  late final TextEditingController timeController;


  var index = 0;
  DateTime? date;
  DateTime? date1;
  String name = "";
  String imagePath = "";
  String userID ="";
  String userId ="";

  late bool ok = false;
  late bool okBeer = false;
  late String pop = items[index];
  int totalTr = 1;
  int totalTr1 = 0;
  late int totala;
  double beer = 0;
  int burger = 0;

  @override
  void initState() {
    super.initState();
    fetchUserID();
    getTotala();
    getNameAndImage();
    getUserScore();
    getOk();
    fetchItems();


    scrollController = FixedExtentScrollController(initialItem: index);
    timeController = TextEditingController(text: '20');
  }

  @override
  void dispose() {
    scrollController.dispose();
    timeController.dispose();

    super.dispose();
  }

//oid updateCal(){
// int n = int.parse(timeController);
// if(n < 60){
//
// } else {
//
// }
//

  late List items = [
    'Välj träning'
  ];
  fetchItems() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('val').doc('items').get();
    items = ds.get('items');

  }

  fetchUserID() async {
    User getUser = FirebaseAuth.instance.currentUser!;
    userID = getUser.uid;
  }

  String getText() {
    if (date == null) {
      return 'Välj Datum';
    } else {
      return DateFormat('yyyy-MM-dd').format(date!);
    }
  }

  getNameAndImage() async {
    fetchUserID();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    name = ds.get('name');
    imagePath = ds.get('imagePath');
  }

  getTotala() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('total').doc('total').get();
    totala = ds.get('total');
  }

  getUserScore() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('top').doc(userID).get();
    totalTr1 = ds.get('totalTr');
    return totalTr1;

  }

  getOk() async{
    fetchUserID();
    FirebaseFirestore.instance.collection('top').doc(userID).get().then((onExists) {
    onExists.exists ? ok = true : ok = false;
    });
  }


  setDataTr() {
    late String dateString = makeDateInt();
    late var dateInt = int.parse(dateString);
    tr.add({
      'name': name,
      'träning': items[index],
      'datum': getText(),
      'tid': dateInt,
      'imagePath': imagePath,
      'userID': userID,
    }).then((value) => print('Top added')).catchError((error)=> Fluttertoast.showToast(msg: 'error $error', textColor: Colors.orange, backgroundColor: Colors.white));
  }

  setDataTop() async {
    getOk();
    getUserScore();
    getTotala();
    if(ok == false){
      top.doc(userID).set({
        'totalTr': totalTr,
        'name': name,
        'imagePath': imagePath,
        'userID': userID,
      }).then((value) => print('Top added')).catchError((error)=> Fluttertoast.showToast(msg: 'error $error', textColor: Colors.orange, backgroundColor: Colors.white));
    }

    else if (ok == true){
      top.doc(userID).update({
        'totalTr': totalTr1 + 1,
        'name': name,
        'imagePath': imagePath,
        'userID': userID,
      }).then((value) => print('Top update')).catchError((error)=> Fluttertoast.showToast(msg: 'error $error', textColor: Colors.orange, backgroundColor: Colors.white));
    }

    total.doc('total').update({
      'total': totala + 1,
    }).then((value) => print('Top update')).catchError((error)=> Fluttertoast.showToast(msg: 'error $error', textColor: Colors.orange, backgroundColor: Colors.white));

  }

  String makeDateInt(){
    if(date == null){
      return 'error';
    } else {
      return DateFormat('yyyyMMdd').format(date!);
    }
  }

  String makeDateshow(){
    if(date1 == null){
      return 'error';
    } else {
      return DateFormat('yyyy-MM-dd').format(date1!);
    }
  }

  late String dateShow = makeDateshow();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lägg till en träning'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*TID FÖR CAL */
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('skriv in tid i minuter',
                      style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                    keyboardType: TextInputType.number,
                    controller: timeController,
                  ),
                ],
              ),
            ),

            /*VÄLJ TRÄNING */
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(16),
                    child: Text(items[index],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      scrollController.dispose();
                      scrollController =
                          FixedExtentScrollController(initialItem: index);

                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              CupertinoActionSheet(
                                actions: [buildPicker()],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Ok'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ));
                    }),
              ),
            ),
            /*VÄLJ DATUM */
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                    onPressed: () => pickDate(context),
                    child: Text(getText(), style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
              ),
            ),
            /*SEND FUNKTION */

            SizedBox(height: 200),

            Material(
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 14,
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                      onPressed: () {
                        showAlertDialog(context);
                        setDataTr();
                        setDataTop();
                        dispose();
                      },
                      child: const Text('Spara Träning',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime
          .now()
          .year - 1),
      lastDate: DateTime
          .now(),
    );
    if (newDate == null) return;
    setState(() => date = newDate);
    setState(()=> date1 = newDate);
  }

  Widget buildPicker() =>
      SizedBox(
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
              final isSelected = this.index == index;
              final item = items[index];
              final color = isSelected
                  ? CupertinoColors.activeOrange
                  : CupertinoColors.black;

              return Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 32),
                  )
              );
            })
        ),
      );
  
  void showAlertDialog(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Träning tillagd'),
      content: Text('Din träning $pop, $dateShow är nu sparad'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

