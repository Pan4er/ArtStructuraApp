import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:artstruktura/health.dart';
import 'package:artstruktura/spirit.dart';
import 'package:artstruktura/trainings.dart';

class CupertinoStoreHomePage extends StatefulWidget {
  const CupertinoStoreHomePage({Key? key}) : super(key: key);

  @override
  _CupertinoStoreHomePageState createState() => _CupertinoStoreHomePageState();
}

class _CupertinoStoreHomePageState extends State<CupertinoStoreHomePage> {
  late Box<int> settingsBox;
  @override
  void initState() {
    super.initState();
    initHive();
    settingsBox = Hive.box<int>("Settings");
  }

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        border: Border(top: BorderSide(width: 0.2)),
        backgroundColor: Color.fromRGBO(34, 40, 49, 1),
        activeColor: Color.fromRGBO(229, 28, 28, 0.85),
        inactiveColor: Colors.white70,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.training),
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.health),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Trainings(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Health(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Spirit(),
              );
            });
          default:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Trainings(),
              );
            });
        }
      },
    );
  }
}
