import 'package:artstruktura/drawer.dart';
import 'package:artstruktura/models/healthExercisesModel.dart';
import 'package:better_video_player/better_video_player.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'RestService.dart';
import 'models/trainingExercisesModel.dart';
import 'package:custom_clippers/custom_clippers.dart';

class HealthExercises extends StatefulWidget {
  late int id;
  late String imageUrl;
  late String comment;
  late String vieoUrl;
  late String name;
  HealthExercises(int id, String comment, String videoUrl, String imageUrl,
      String healthComment) {
    this.id = id;
    this.comment = comment;
    this.vieoUrl = videoUrl;
    this.imageUrl = imageUrl;
    this.name = healthComment;
  }

  @override
  State<HealthExercises> createState() => _HealthExercisesState(
      this.id, this.comment, this.vieoUrl, this.imageUrl, this.name);
}

class _HealthExercisesState extends State<HealthExercises> {
  late int id;
  late String healthComment;
  late String videoUrl;
  late String imageUrl;
  late String healthName;

  _HealthExercisesState(int id, String healthComment, String videoUrl,
      String imgUrl, String healthName) {
    this.id = id;
    this.healthComment = healthComment;
    this.videoUrl = videoUrl;
    this.imageUrl = imgUrl;
    this.healthName = healthName;
  }
  late Future<HealthExModel> hexercises;
  late Box<int> settingsBox;
  var controller = BetterVideoPlayerController();
  var mainScrollController = ScrollController();
  var exScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    initHive();

    settingsBox = Hive.box<int>("Settings");
    hexercises = RestService.getHealthExercises(id);
  }

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
              child: Scrollbar(
            controller: mainScrollController,
            //isAlwaysShown: true,
            trackVisibility: true,
            interactive: true,
            thickness: 30,
            //hoverThickness: 30,
            child: ListView(
                physics: BouncingScrollPhysics(),
                controller: mainScrollController,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: BetterVideoPlayer(
                          configuration: BetterVideoPlayerConfiguration(
                              autoPlay: false,
                              placeholder: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(imageUrl),
                              )),
                          controller: controller,
                          dataSource: BetterVideoPlayerDataSource(
                            BetterVideoPlayerDataSourceType.network,
                            videoUrl,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7, left: 7),
                        height: 38,
                        width: 38,
                        child: IconButton(
                          iconSize: 22,
                          alignment: Alignment.center,
                          icon: Icon(Icons.arrow_back_rounded),
                          onPressed: () {
                            controller.pause();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: -7,
                        right: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new IconButton(
                              icon: Icon(
                                Icons.announcement,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          elevation: 12,
                                          backgroundColor:
                                              Color.fromRGBO(34, 40, 49, 1),
                                          content: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 400,
                                            child: ListView(
                                              physics: BouncingScrollPhysics(),
                                              children: [
                                                ListTile(
                                                    title: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 30, bottom: 10),
                                                  child: ClipPath(
                                                    clipper:
                                                        LowerNipMessageClipper(
                                                            MessageType
                                                                .RECEIVE),
                                                    child: Container(
                                                        height: 300,
                                                        width: 200,
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 16,
                                                          right: 16,
                                                          top: 16,
                                                        ),
                                                        color: Colors.red[400],
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: ListView(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                healthComment,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                )),
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    right: 45,
                                                  ),
                                                  leading: Container(
                                                    width: 85,
                                                    height: 85,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "lib/img/Arthour.jpg"))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    });
                              }),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Center(
                    child: Text(
                      settingsBox.get("lang") == 0 ? "Упражнения" : "Exercises",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 18, left: 12, right: 12, bottom: 12),
                    child: Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Color.fromRGBO(34, 40, 49, 0.9),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        elevation: 5.0,
                        child: FutureBuilder<HealthExModel>(
                            future: hexercises,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        snapshot.data!.healthExcersises!.length,
                                    itemBuilder: (context, index) {
                                      var exr = snapshot
                                          .data!.healthExcersises![index];
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 17, top: 7),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    var time = exr.hExStartTime!
                                                        .split(":");
                                                    mainScrollController
                                                        .animateTo(0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    40),
                                                            curve:
                                                                Curves.easeIn);
                                                    controller.seekTo(Duration(
                                                        minutes:
                                                            int.parse(time[0]),
                                                        seconds: int.parse(
                                                            time[1])));
                                                    controller.play();
                                                  },
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 7),
                                                    isThreeLine: true,
                                                    title: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 6),
                                                      child: Text(
                                                        settingsBox.get(
                                                                    "lang") ==
                                                                0
                                                            ? exr.hExName ?? ''
                                                            : exr.hExNameEn ??
                                                                '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    subtitle: Text(settingsBox
                                                                .get("lang") ==
                                                            0
                                                        ? exr.hExComment ?? ''
                                                        : exr.hExCommentEn ??
                                                            ''),
                                                    leading: Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: ClipRRect(
                                                          child: FadeInImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                exr.hExThumbnailUrl ??
                                                                    ''),
                                                            placeholder: AssetImage(
                                                                "lib/img/bluredTrainig.jpg"),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                        )),
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6, top: 12),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            237, 26, 65, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            settingsBox.get(
                                                                        "lang") ==
                                                                    0
                                                                ? exr.hExRestTime ??
                                                                    ''
                                                                : exr.hExRestTimeEn ??
                                                                    '',
                                                            style:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12)),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i < 70;
                                                            i++)
                                                          Container(
                                                            width: 3,
                                                            height: 1,
                                                            decoration: BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        237,
                                                                        26,
                                                                        65,
                                                                        1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2)),
                                                          )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ));
                                    });
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                ]),
          )),
        ),
        onWillPop: () async {
          controller.pause();
          return true;
        });
  }
}
