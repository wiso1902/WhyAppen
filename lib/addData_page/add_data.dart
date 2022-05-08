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
  CollectionReference beerBurgers = FirebaseFirestore.instance.collection('beerBurger');
  final FirebaseAuth auth = FirebaseAuth.instance;

  late DatabaseReference databaseReference;
  late FixedExtentScrollController scrollController;
  late final TextEditingController timeController;


  var index = 0;
  DateTime? date;
  DateTime? date1;
  String name = "";
  String userID ="";
  String userId ="";

  late bool ok = false;
  late bool okBeer = false;
  int totalTr = 1;
  int totalTr1 = 0;
  late int totala;
  int beer = 0;
  int burger = 0;

  final items = [
    'Prommenad',
    'Skidor',
    'Joggning',
    'Gym',
    'Simmning',
    'Hockey',
    'Rid pass',
    'Hund Prommenad',
    'Golf',
    '+'
  ];

  getBeer() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('beerBurger').doc(userID).get();
    beer = ds.get('beer');
    burger = ds.get('burger');
  }

  calcBeer(){
    getBeer();
    if (beer == 3){
      burger++;
      beer = 0;
    } else {
      beer++;
    }
  }

  sendBeerBurger() async {
    getBeer();
    calcBeer();
    if (okBeer == false){
      beerBurgers.doc(userID).set({
        'beer': 1,
        'burger': 0,
      });
    } if (okBeer == true){
      beerBurgers.doc(userID).update({
        'beer': beer,
        'burger': burger,
      });
    }

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

  getName() async {
    fetchUserID();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    name = ds.get('name');
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

  getOkBeer() async {
    fetchUserID();
    FirebaseFirestore.instance.collection('beerBurger').doc(userID).get().then((onExists) {
      onExists.exists ? okBeer = true : okBeer = false;
    });
  }

  getOk() async{
    fetchUserID();
    FirebaseFirestore.instance.collection('top').doc(userID).get().then((onExists) {
    onExists.exists ? ok = true : ok = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserID();
    getTotala();
    getName();
    getUserScore();
    getOk();
    getBeer();
    getOkBeer();


    scrollController = FixedExtentScrollController(initialItem: index);
    timeController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    scrollController.dispose();
    timeController.dispose();

    super.dispose();
  }


  setDataTr() {
    tr.add({
      'name': name,
      'träning': items[index],
      'datum': getText(),
      'tid': dateInt,
      'userID': userID,
    }).then((value) => print('user added')).catchError((error)=> print('fel: $error'));
  }

  setDataTop() async {
    getUserScore();
    getTotala();
    if(ok == false){
      top.doc(userID).set({
        'totalTr': totalTr,
        'name': name,
        'userID': userID,
      }).then((value) => print('Top added')).catchError((error)=> print('fel: $error'));
    }
    else if (ok == true){
      top.doc(userID).update({
        'totalTr': totalTr1 + 1,
        'name': name,
        'userID': userID,
      }).then((value) => print('Top update')).catchError((error)=> print('fel: $error'));
    }

    total.doc('total').update({
      'total': totala + 1,
    }).then((value) => print('Top update')).catchError((error)=> print('fel: $error'));

  }

  String makeDateInt(){
    if(date1 == null){
      return 'error';
    } else {
      return DateFormat('yyyyMMdd').format(date1!);
    }
  }
  late String dateString = makeDateInt();
  late var dateInt = int.parse(dateString);

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
                  TextField(decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
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
                  borderRadius: BorderRadius.circular(32),
                ),
                child: CupertinoButton.filled(
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
                                  child: const Text('Cancel'),
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
                        color: Colors.white, fontWeight: FontWeight.bold),)),
              ),
            ),
            /*SEND FUNKTION */
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                    onPressed: () {
                      setDataTr();
                      setDataTop();
                      sendBeerBurger();
                      Fluttertoast.showToast(msg: "Träning tillagd");
                    },
                    child: const Text('Spara Träning',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ))),
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
}
