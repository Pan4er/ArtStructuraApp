// ignore_for_file: file_names

import 'package:artstruktura/models/constructorGeneratedTrainingModel.dart';
import 'package:artstruktura/restServicePost.dart';
import 'package:better_video_player/better_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GeneratedTrainingByConstructor extends StatefulWidget {
  //const GeneratedTraining({Key? key}) : super(key: key);
  //List<String> generalFilter;
  List<String> generalFilter;

  GeneratedTrainingByConstructor(this.generalFilter);

  @override
  State<GeneratedTrainingByConstructor> createState() =>
      _GeneratedTrainingByConstructorState(generalFilter);
}

class _GeneratedTrainingByConstructorState
    extends State<GeneratedTrainingByConstructor> {
  List<String> filter;
  late Box<int> settingsBox;
  late int pages;
  late Future<constructorGeneratedTrainingModel> genTrenModel;
  int currentCategorieId = -1;
  bool useFilter = false;
  String currentVideoUrl = "";
  int currentPage = 0;
  int videoCount = 0;
  PageController pageController = PageController();
  var videoPlayerController = BetterVideoPlayerController();
  List<BetterVideoPlayerController> videoControllers = [];
  Icon currentSearchIcon = Icon(Icons.search);
  _GeneratedTrainingByConstructorState(this.filter);
  @override
  void initState() {
    super.initState();
    initHive();
    settingsBox = Hive.box<int>("Settings");
    genTrenModel = RestServicePost.postRequest(this.filter);
  }

  void makeVideoPlayerControllers() async {}

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<constructorGeneratedTrainingModel>(
            future: genTrenModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                    color: Colors.redAccent,
                    child: PageView.builder(
                        controller: pageController,
                        onPageChanged: (pageNumber) {
                          /*setState(() {
                            currentPage = pageNumber;
                          });*/
                          setState(() {
                            for (var i = 0; i < videoControllers.length; i++) {
                              if (i == pageNumber) {
                                videoControllers[i].play();
                              } else {
                                videoControllers[i].pause();
                              }
                            }
                          });
                        },
                        //physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.generatedTraining!.length,
                        itemBuilder: (context, index) {
                          var training =
                              snapshot.data!.generatedTraining![index];

                          /*if (videoControllers.isNotEmpty) {
                            for (var i = 0;
                                i < snapshot.data!.generatedTraining!.length;
                                i++) {
                              videoControllers[i].dispose();
                            }
                          }*/

                          for (var i = 0;
                              i < snapshot.data!.generatedTraining!.length;
                              i++) {
                            videoControllers.add(BetterVideoPlayerController());
                          }

                          return AspectRatio(
                            aspectRatio: 16.0 / 9.0,
                            child: BetterVideoPlayer(
                              configuration: BetterVideoPlayerConfiguration(
                                autoPlay: true,
                              ),
                              controller: BetterVideoPlayerController(),
                              dataSource: BetterVideoPlayerDataSource(
                                BetterVideoPlayerDataSourceType.network,
                                training.exVideoUrl ?? "",
                              ),
                            ),
                          );
                        }),
                    onRefresh: refreshTr);
              } else {
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.redAccent)));
              }
            }));
  }

  Future refreshTr() async {
    genTrenModel = RestServicePost.postRequest(this.filter);
  }
}
