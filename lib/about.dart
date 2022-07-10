import 'package:artstruktura/text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
        title: Text(settingsBox.get("lang") == 0
            ? "Что такое Арт структура?"
            : "What is an Art struktura?"),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("lib/img/whatIs.jpg"))),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(settingsBox.get("lang") == 0 ? about : aboutEn,
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
