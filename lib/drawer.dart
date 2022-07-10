import 'package:google_ui/google_ui.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flag/flag.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:artstruktura/about.dart';
import 'package:artstruktura/founder.dart';
import 'package:flutter/material.dart';
import 'custom_icons.dart';

class DrawerListview extends StatefulWidget {
  const DrawerListview({Key? key}) : super(key: key);

  @override
  State<DrawerListview> createState() => _DrawerListviewState();
}

class _DrawerListviewState extends State<DrawerListview> {
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
    return ListView(
      children: [
        DrawerHeader(
          child: null,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("lib/img/drawerLogo.jpg"))),
        ),
        ListTile(
          leading: Icon(CustomIcons.flash),
          title: Text(settingsBox.get("lang") == 0
              ? "Что такое Арт структура?"
              : "What is an Art struktura?"),
          contentPadding: EdgeInsets.all(12),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new AboutPage()));
          },
        ),
        ListTile(
          leading: Icon(CustomIcons.language),
          title: Text(settingsBox.get("lang") == 0
              ? "Выбрать язык"
              : "Choose language"),
          contentPadding: EdgeInsets.all(12),
          onTap: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        backgroundColor: Color.fromRGBO(34, 40, 49, 1),
                        content: SizedBox(
                          width: 150,
                          height: 150,
                          child: GSelectBox<int>(
                            value: settingsBox.get("lang") ?? 0,
                            items: [
                              GSelectBoxItem(
                                icon: Flag.fromCode(
                                  FlagsCode.RU,
                                  height: 15,
                                  width: 25,
                                ),
                                title: "Русский",
                                value: 0,
                              ),
                              GSelectBoxItem(
                                icon: Flag.fromCode(
                                  FlagsCode.US,
                                  height: 15,
                                  width: 25,
                                ),
                                title: "English",
                                value: 1,
                              ),
                            ],
                            onChanged: (value) {
                              settingsBox.put("lang", value);
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            },
                          ),
                        ),
                      ));
            });
          },
        ),
        ListTile(
          leading: Icon(CustomIcons.founder),
          title: Text(settingsBox.get("lang") == 0
              ? "Об основателе"
              : "About the founder"),
          contentPadding: EdgeInsets.all(12),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Founder()));
          },
        ),
        ListTile(
          leading: Icon(CustomIcons.network),
          title: Text(settingsBox.get("lang") == 0
              ? "Ссылки на соц сети"
              : "Links to social networks"),
          contentPadding: EdgeInsets.all(12),
          onTap: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        backgroundColor: Color.fromRGBO(34, 40, 49, 1),
                        content: SizedBox(
                          width: 260,
                          height: 230,
                          child: ListView(
                            children: [
                              ListTile(
                                leading: Icon(CustomIcons.vk),
                                title: Text(
                                    settingsBox.get("lang") == 0 ? "Вк" : "Vk"),
                                onTap: () {
                                  launchInBrowser(
                                      "https://vk.com/art_structura");
                                },
                              ),
                              ListTile(
                                leading: Icon(CustomIcons.instagram),
                                title: Text(settingsBox.get("lang") == 0
                                    ? "Инстаграм"
                                    : "Instagram"),
                                onTap: () {
                                  launchInBrowser(
                                      "https://www.instagram.com/art_structura/");
                                },
                              ),
                              ListTile(
                                leading: Icon(CustomIcons.youtube),
                                title: Text(settingsBox.get("lang") == 0
                                    ? "Ютуб"
                                    : "Youtube"),
                                onTap: () {
                                  launchInBrowser(
                                      "https://www.youtube.com/channel/UCEOKXEd7Kr4lSYkOkjq70aw/featured");
                                },
                              ),
                              ListTile(
                                leading: Icon(CustomIcons.telegram_plane),
                                title: Text(settingsBox.get("lang") == 0
                                    ? "Телеграм"
                                    : "Telegram"),
                                onTap: () {
                                  launchInBrowser(
                                      "https://t.me/art_structura1");
                                },
                              )
                            ],
                          ),
                        ),
                      ));
            });
          },
        ),
      ],
    );
  }
}

Future<void> launchInBrowser(String url) async {
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}
