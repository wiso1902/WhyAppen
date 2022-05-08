
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    required this.text,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late final TextEditingController controller;
  String userID = "";
  late String imagePath = 'https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/why-avatar.png?alt=media&token=47dd9052-b409-4254-87d4-53f1ded04869';
  late bool ok = false;

  fetchUserID() async {
    User getUser = FirebaseAuth.instance.currentUser!;
    userID = getUser.uid;
  }

  @override
  void initState() {
    super.initState();
    fetchUserID();
    getOk();

    controller = TextEditingController(text: widget.text);
  }

  getOk() async{
    fetchUserID();
    FirebaseFirestore.instance.collection('users').doc(userID).get().then((onExists) {
      onExists.exists ? ok = true : ok = false;
    });
  }

  addUser() {
    if(ok == false) {
      users.doc(userID).set({
        'name': controller.text.toString(),
        'imagePath': imagePath,
      });
    } else if(ok == true) {
      users.doc(userID).update({
        'name': controller.text.toString(),
        'imagePath': imagePath,
      });
    }
  }

  @override
  void dsipose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(Theme
                    .of(context)
                    .colorScheme
                    .primary),
              ),
            ]),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            controller: controller,
          ),
          TextButton(
              onPressed: () {
                addUser();
              },
              child: Text('Spara'))
        ],
      );

  buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: () => pickImage(),
          ),
        ),
      ),
    );
  }

  piickImage() {

  }

  pickImage() async {
    final storage = FirebaseStorage.instance;
    final picker = ImagePicker();
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      var image = await picker.pickImage(source: ImageSource.gallery);
      var file = File(image!.path);
      String fileName = basename(image.path);

      if (image != null) {
        var snapshot = await storage.ref().child(fileName).putFile(file);

        var downloadURL = await snapshot.ref.getDownloadURL();
        setState(() {
          imagePath = downloadURL;
        });
      } else {
        users.doc(userID).set({
          'imagePath': imagePath,
        });
        print('ingen bild vald');
      }
    } else {
      print('Ge tillåtelse och försök igen');
    }
  }


  Widget buildEditIcon(Color color) =>
      buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
