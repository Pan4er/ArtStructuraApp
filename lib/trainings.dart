import 'package:artstruktura/drawer.dart';
import 'package:artstruktura/models/traingCatModel.dart';
import 'package:artstruktura/restService.dart';
import 'package:artstruktura/trainingExercises.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_ui/google_ui.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:artstruktura/models/trainingsModel.dart';

class Trainings extends StatefulWidget {
  const Trainings({Key? key}) : super(key: key);

  @override
  State<Trainings> createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {
  ScrollController listViewScrollController = ScrollController();
  late Box<int> settingsBox;
  TextEditingController textController = TextEditingController();
  late int currentLimit;
  bool hasmore = true;
  bool search = false;
  int currentLen = 5;
  bool isloading = false;
  Widget currentTextBar = Text("text");
  String currentWordToSearch = "";
  Icon currentSearchIcon = Icon(Icons.search);
  late Future<TrainingsModel> trainings;
  late Future<TrainingCat> categories;

  @override
  void initState() {
    super.initState();
    initHive();

    currentLimit = 5;
    settingsBox = Hive.box<int>("Settings");
    currentTextBar =
        settingsBox.get("lang") == 0 ? Text("Тренировки") : Text("Trainings");
    trainings = RestService.getTrainings(currentLimit, currentWordToSearch);
    categories = RestService.getTrainingCategories();
    listViewScrollController.addListener(() {
      if (listViewScrollController.position.maxScrollExtent ==
          listViewScrollController.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    if (isloading == true) return;
    setState(() {
      isloading = true;
    });
    setState(() {
      if (currentLen < currentLimit) {
        hasmore = false;
      }
      currentLimit = currentLimit + 5;

      trainings = RestService.getTrainings(currentLimit, currentWordToSearch);
      setState(() {
        isloading = false;
      });
    });
  }

  Future refresh() async {
    if (currentWordToSearch == "") {
      setState(() {
        isloading = false;
        hasmore = true;
        currentLimit = 5;
        trainings = RestService.getTrainings(currentLimit, currentWordToSearch);
      });
    } else {
      setState(() {
        if (currentLen < 3) {
          isloading = false;
          hasmore = false;
          currentLimit = 5;
          trainings =
              RestService.getTrainings(currentLimit, currentWordToSearch);
          listViewScrollController.animateTo(20,
              duration: Duration(milliseconds: 50), curve: Curves.easeIn);
        } else {
          isloading = false;
          hasmore = true;
          currentLimit = 5;
          trainings =
              RestService.getTrainings(currentLimit, currentWordToSearch);
          listViewScrollController.animateTo(20,
              duration: Duration(milliseconds: 50), curve: Curves.easeIn);
        }
      });
    }
  }

  Future refreshCategories() async {
    categories = RestService.getTrainingCategories();
  }

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: DrawerListview()),
        appBar: settingsBox.get("layout") == 0
            ? AppBar(
                actions: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (currentSearchIcon.icon == Icons.search) {
                            currentSearchIcon = Icon(Icons.cancel);
                            search = true;
                            currentTextBar = TextField(
                              cursorColor: Colors.white,
                              controller: textController,
                              onChanged: (value) {
                                setState(() {
                                  currentWordToSearch = value;

                                  refresh();
                                });
                              },
                              autofocus: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: settingsBox.get("lang") == 0
                                      ? "Поиск"
                                      : "Search",
                                  hintStyle: TextStyle(color: Colors.white38),
                                  helperStyle:
                                      TextStyle(color: Colors.white38)),
                              textInputAction: TextInputAction.go,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            );
                          } else {
                            setState(() {
                              search = false;
                              currentWordToSearch = "";
                              refresh();
                              listViewScrollController.animateTo(0,
                                  duration: Duration(milliseconds: 50),
                                  curve: Curves.easeIn);
                              currentSearchIcon = Icon(Icons.search);
                              currentTextBar = settingsBox.get("lang") == 0
                                  ? Text("Тренировки")
                                  : Text("Trainings");
                            });
                          }
                        });
                      },
                      icon: currentSearchIcon,
                      tooltip: settingsBox.get("lang") == 0
                          ? "Поиск по тексту"
                          : "Search by text",
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list_alt),
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(34, 40, 49, 1),
                                    content: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: GSelectBox<int>(
                                        value: settingsBox.get("layout") ?? 0,
                                        items: [
                                          GSelectBoxItem(
                                            icon: Icon(Icons.search),
                                            title: settingsBox.get("lang") == 0
                                                ? "Поиск по тексту"
                                                : "Search by text",
                                            value: 0,
                                          ),
                                          GSelectBoxItem(
                                            icon: Icon(Icons.category),
                                            title: settingsBox.get("lang") == 0
                                                ? "Поиск по категориям"
                                                : "Search by category",
                                            value: 1,
                                          ),
                                        ],
                                        onChanged: (value) {
                                          settingsBox.put("layout", value);
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                        },
                                      ),
                                    ),
                                  ));
                        });
                      },
                    )
                  ],
                title: Builder(
                  builder: (context) {
                    if (!search) {
                      settingsBox.get("lang") == 0
                          ? currentTextBar = Text("Тренировки")
                          : currentTextBar = Text("Trainings");
                    }
                    return currentTextBar;
                  },
                ))
            : AppBar(
                actions: [
                  IconButton(
                    icon: Icon(Icons.filter_list_alt),
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  backgroundColor:
                                      Color.fromRGBO(34, 40, 49, 1),
                                  content: SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: GSelectBox<int>(
                                      value: settingsBox.get("layout") ?? 0,
                                      items: [
                                        GSelectBoxItem(
                                          icon: Icon(Icons.search),
                                          title: settingsBox.get("lang") == 0
                                              ? "Поиск по тексту"
                                              : "Search by text",
                                          value: 0,
                                        ),
                                        GSelectBoxItem(
                                          icon: Icon(Icons.category),
                                          title: settingsBox.get("lang") == 0
                                              ? "Поиск по категориям"
                                              : "Search by category",
                                          value: 1,
                                        ),
                                      ],
                                      onChanged: (value) {
                                        settingsBox.put("layout", value);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                    ),
                                  ),
                                ));
                      });
                    },
                  )
                ],
                title: settingsBox.get("lang") == 0
                    ? Text("Тренировки")
                    : Text("Trainings"),
              ),
        body: settingsBox.get("layout") == 0
            ? FutureBuilder<TrainingsModel>(
                future: trainings,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      color: Colors.redAccent,
                      onRefresh: refresh,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: listViewScrollController,
                          itemCount: snapshot.data!.trainings!.length + 1,
                          itemBuilder: (context, index) {
                            if (index < snapshot.data!.trainings!.length) {
                              var trainings = snapshot.data!.trainings![index];
                              currentLen = snapshot.data!.trainings!.length;
                              return Padding(
                                  padding: EdgeInsets.all(15),
                                  child: buildCard(
                                      settingsBox.get("lang") == 0
                                          ? trainings.trainingName ?? ''
                                          : trainings.trainingNameEn ?? '',
                                      trainings.imageUrl ?? '',
                                      trainings.id ?? 0,
                                      settingsBox.get("lang") == 0
                                          ? trainings.trainingComment ?? ''
                                          : trainings.trainingCommentEn ?? '',
                                      trainings.videoUrl ?? ''));
                            } else {
                              return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: Center(
                                    child: hasmore
                                        ? CircularProgressIndicator(
                                            color: Colors.redAccent)
                                        : Text(''),
                                  ));
                            }
                          }),
                    );
                  } else {
                    return Center(
                        child:
                            CircularProgressIndicator(color: Colors.redAccent));
                  }
                },
              )
            : FutureBuilder<TrainingCat>(
                future: categories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                        color: Colors.redAccent,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.categories!.length,
                            itemBuilder: (context, index) {
                              var categoriesList =
                                  snapshot.data!.categories![index];
                              return buildCategorieCard(
                                  settingsBox.get("lang") == 0
                                      ? categoriesList.categorieName ?? ''
                                      : categoriesList.categorieNameEn ?? '',
                                  categoriesList.id ?? 0);
                            }),
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

  Builder buildCategorieCard(String categorieName, int categorieId) {
    var trainingsByCategorie = RestService.getTrainingByCategorie(categorieId);
    return Builder(
      builder: (context) {
        return Card(
          margin: EdgeInsets.all(12),
          color: Color.fromRGBO(34, 40, 49, 0.9),
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.4),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          elevation: 5.0,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  categorieName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      wordSpacing: 0.5,
                      fontSize: 18),
                ),
              ),
              Divider(),
              Container(
                  height: 280.0,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<TrainingsModel>(
                    future: trainingsByCategorie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.trainings!.length,
                            itemBuilder: (context, index) {
                              var training = snapshot.data!.trainings![index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: 6, left: 9, right: 9, bottom: 12),
                                child: Container(
                                  width: 200,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 250,
                                          height: 140,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          TrainingExercises(
                                                              training.id ?? 0,
                                                              settingsBox.get(
                                                                          "lang") ==
                                                                      0
                                                                  ? training.trainingComment ??
                                                                      ''
                                                                  : training
                                                                          .trainingCommentEn ??
                                                                      '',
                                                              training
                                                                      .videoUrl ??
                                                                  '',
                                                              training
                                                                      .imageUrl ??
                                                                  '',
                                                              settingsBox.get(
                                                                          "lang") ==
                                                                      0
                                                                  ? training
                                                                          .trainingName ??
                                                                      ''
                                                                  : training
                                                                          .trainingNameEn ??
                                                                      '')));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              child: FadeInImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    training.imageUrl ?? ''),
                                                placeholder: AssetImage(
                                                    "lib/img/bluredTrainig.jpg"),
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          settingsBox.get("lang") == 0
                                              ? training.trainingName ?? ''
                                              : training.trainingNameEn ?? '',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                          overflow: TextOverflow.visible,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.redAccent,
                        ));
                      }
                    },
                  ))
            ],
          ),
        );
      },
    );
  }

  Builder buildCard(String trainingName, String imgUrl, int trainigId,
      String trainingComment, String videoUrl) {
    var cardImage = NetworkImage(imgUrl);
    var fadedImage = FadeInImage(
        fit: BoxFit.fill,
        placeholder: AssetImage("lib/img/bluredTrainig.jpg"),
        image: cardImage);

    return Builder(
      builder: (context) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => TrainingExercises(
                        trainigId,
                        trainingComment,
                        videoUrl,
                        imgUrl,
                        trainingName)));
          },
          child: Card(
              color: Color.fromRGBO(34, 40, 49, 0.9),
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.4),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              elevation: 5.0,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      trainingName,
                      style: TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 0.5,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        child: fadedImage,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ))
                ],
              )),
        );
      },
    );
  }
}
