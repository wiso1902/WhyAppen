import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:why_appen/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Skapa ett inlägg'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Ta en bild'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Välj en bild'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Scaffold(
            backgroundColor: Color(0xFFEDF0F6),
            body: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Why Flödet',
                        style: TextStyle(
                          fontFamily: 'Billabong',
                          fontSize: 32.0,
                          color: Colors.orange
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 560.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                child: ClipOval(
                                  child: Image(
                                    height: 50.0,
                                    width: 50.0,
                                    image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/why-avatar.png?alt=media&token=47dd9052-b409-4254-87d4-53f1ded04869'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              'William',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text('2 min'),
                            trailing: IconButton(
                              icon: Icon(Icons.more_horiz),
                              color: Colors.orangeAccent,
                              onPressed: () => _selectImage(context),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            width: double.infinity,
                            height: 400.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 5),
                                  blurRadius: 8.0,
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/image_picker2705355827175581607.jpg?alt=media&token=0295dd66-79c6-4e98-8cdf-d4e7f72739c7'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () => print('like'),
                                      icon: Icon(Icons.favorite_border, color: Colors.orangeAccent,),
                                      iconSize: 30,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: const Text('Ladda upp bild'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/why-avatar.png?alt=media&token=47dd9052-b409-4254-87d4-53f1ded04869'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Lägg till en beskrivning',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/why-appen.appspot.com/o/why-avatar.png?alt=media&token=47dd9052-b409-4254-87d4-53f1ded04869'),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
