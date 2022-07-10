import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:artstruktura/text.dart';

class Founder extends StatefulWidget {
  const Founder({Key? key}) : super(key: key);

  @override
  State<Founder> createState() => _FounderState();
}

class _FounderState extends State<Founder> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsBox.get("lang") == 0 ? "Основатель" : "Founder"),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            height: 300,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("lib/img/founder2.jpg"))),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(settingsBox.get("lang") == 0 ? founder : founderEn,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  letterSpacing: 0.2,
                  wordSpacing: 0.5,
                )),
          )
        ],
      ),
    );
  }
}
