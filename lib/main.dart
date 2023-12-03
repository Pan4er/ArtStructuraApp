import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wakelock/wakelock.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  await Hive.openBox<int>("Settings");
  Wakelock.enable();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(StrukturaApp());
}

class StrukturaApp extends StatefulWidget {
  const StrukturaApp({Key? key}) : super(key: key);

  @override
  StrukturaAppState createState() => StrukturaAppState();
}

class StrukturaAppState extends State<StrukturaApp> {
  final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,


    canvasColor: Color.fromRGBO(34, 40, 49, 1),

    //scaffoldBackgroundColor: Colors.grey[850],
    scaffoldBackgroundColor: Color.fromRGBO(34, 40, 49, 1),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Color.fromRGBO(34, 40, 49, 1),
    ),
    hintColor: Colors.blue[500],
  );

  late Box<int> settingsBox;

  @override
  void initState() {
    super.initState();
    settingsBox = Hive.box<int>("Settings");
    if (settingsBox.get("lang") == null) settingsBox.put("lang", 0);
    if (settingsBox.get("layout") == null) settingsBox.put("layout", 1);
    if (settingsBox.get("isDescOn") == null) {
      settingsBox.put("isDescOn", 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art Structura',
      debugShowCheckedModeBanner: false,
      theme: dark,
      home: CupertinoStoreHomePage(),
    );
  }
}
