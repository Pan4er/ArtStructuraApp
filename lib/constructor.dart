import 'dart:convert';
import 'dart:ui';
import 'package:artstruktura/generatedTrainingFromConstruct.dart';

import 'package:http/http.dart' as http;
import 'package:artstruktura/drawer.dart';
import 'package:artstruktura/models/musicCatModel.dart';
import 'package:artstruktura/models/musicModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:artstruktura/restService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:artstruktura/models/constructorCatModel.dart';
import 'package:artstruktura/restServicePost.dart';

import 'ListPlayerPage.dart';

class Constructor extends StatefulWidget {
  const Constructor({Key? key}) : super(key: key);

  @override
  State<Constructor> createState() => _ConstructorState();
}

class _ConstructorState extends State<Constructor> {
  late Box<int> settingsBox;
  late Future<constructorCatModel> categories;

  final List<String?> filters = <String?>[];
  int currentCategorieId = -1;
  bool useFilter = false;
  @override
  void initState() {
    super.initState();
    initHive();
    settingsBox = Hive.box<int>("Settings");
    categories = RestService.getConstructorCategories();
    filters.add("holodnRastyajka");
    filters.add("triceps");
    filters.add("mishziGrudi");
  }

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: DrawerListview()),
        appBar: AppBar(
          title: Text(settingsBox.get("lang") == 0
              ? "Конструктор тренировки"
              : "workout constructor"),
        ),
        body: FutureBuilder<constructorCatModel>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40, left: 8, right: 8),
                      child: ListView(
                        children: [
                          Card(
                            margin: EdgeInsets.all(6),
                            color: Color.fromRGBO(34, 40, 49, 0.9),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            elevation: 15.0,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    settingsBox.get("lang") == 0
                                        ? "Что вы хотите проработать?"
                                        : "What do you want to work on?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.2,
                                        wordSpacing: 0.5,
                                        fontSize: 19),
                                  ),
                                ),
                                Divider(),
                                Container(
                                    padding: EdgeInsets.only(bottom: 4),
                                    height: 320.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: Scrollbar(
                                      child: GridView.builder(
                                          padding: EdgeInsets.only(
                                              bottom: 16,
                                              top: 9,
                                              left: 9,
                                              right: 9),
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 30,
                                                  mainAxisExtent: 200,
                                                  crossAxisSpacing: 35,
                                                  mainAxisSpacing: 5),
                                          itemCount: snapshot.data!
                                              .constructorCategories!.length,
                                          itemBuilder: (context, index) {
                                            var categoriesList = snapshot.data!
                                                .constructorCategories![index];
                                            return FilterChip(
                                              //backgroundColor: Colors.red[200],
                                              label: Text(
                                                settingsBox.get("lang") == 0
                                                    ? categoriesList
                                                            .constName ??
                                                        ''
                                                    : categoriesList
                                                            .constNameEn ??
                                                        '',
                                                style: TextStyle(),
                                              ),
                                              selected: filters.contains(
                                                  categoriesList.constValue),
                                              selectedColor: Colors.red,
                                              onSelected: (value) {
                                                setState(() {
                                                  if (value) {
                                                    if (!filters.contains(
                                                        categoriesList
                                                            .constValue)) {
                                                      filters.add(categoriesList
                                                          .constValue);
                                                    }
                                                  } else {
                                                    filters.removeWhere(
                                                        (String? name) {
                                                      return name ==
                                                          categoriesList
                                                              .constValue;
                                                    });
                                                  }
                                                });
                                              },
                                            );
                                          }),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 80, left: 20, right: 20),
                              child: OutlineButton(
                                highlightColor: Colors.redAccent,
                                highlightedBorderColor: Colors.redAccent,
                                highlightElevation: 0.1,
                                splashColor: Colors.redAccent,
                                color: Colors.redAccent,
                                borderSide: BorderSide(color: Colors.redAccent),
                                child: Center(
                                    child: SizedBox(
                                        width: 250,
                                        height: 60,
                                        child: Center(
                                          child: Text(
                                            settingsBox.get("lang") == 0
                                                ? "Создать тренировку"
                                                : "Generate training",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) => new
                                              /*GeneratedTrainingByConstructor(
                                                  toStrList(filters))*/
                                              GeneratedTrainingByConstructor2(
                                                  toStrList(filters))));
                                },
                              )),
                        ],
                      ),
                    ),
                    onRefresh: refreshCategories);
              } else {
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.redAccent)));
              }
            }));
  }

  Future refreshCategories() async {
    categories = RestService.getConstructorCategories();
  }
}

List<String> toStrList(List<String?> listq) => List.from(listq);
