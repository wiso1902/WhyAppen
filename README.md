# why_appen

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


TODO
// prem for ios
add to info.plist

<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs to access photo library</string>
<key>NSCameraUsageDescription</key>
<string>This app needs Camera Usage</string>

//ALert dialog

Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { "colose dialog" },
  );

AlertDialog(
      title: new Text("text", Color color.orange),
      content: new Text(this._content),
      backgroundColor: Color(color.white),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          
          actions: [
      okButton,
    ],
  );
