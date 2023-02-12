// ignore_for_file: file_names
import 'dart:ui' as ui;
import 'dart:async';
import 'package:artstruktura/models/constructorGeneratedTrainingModel.dart';
import 'package:artstruktura/restServicePost.dart';
import 'package:better_video_player/better_video_player.dart';
import 'constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:glass_kit/glass_kit.dart';

class GeneratedTrainingByConstructor2 extends StatefulWidget {
  List<String> generalFilter;
  GeneratedTrainingByConstructor2(this.generalFilter);

  @override
  _GeneratedTrainingByConstructor2State createState() =>
      _GeneratedTrainingByConstructor2State(generalFilter);
}

class _GeneratedTrainingByConstructor2State
    extends State<GeneratedTrainingByConstructor2> {
  int _playingIndex = -1;
  List<String> filter;
  late Box<int> settingsBox;
  bool isDescOn = true;
  bool isVideoOver = false;
  late Future<constructorGeneratedTrainingModel> genTrenModel;
  _GeneratedTrainingByConstructor2State(this.filter);

  @override
  void initState() {
    super.initState();
    initHive();
    settingsBox = Hive.box<int>("Settings");
    genTrenModel = RestServicePost.postRequest(this.filter);
    _playingIndex = 0;
  }

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  Future refreshTr() async {
    genTrenModel = RestServicePost.postRequest(this.filter);
  }

  bool intToBool(int val) {
    if (val == 0) {
      return false;
    } else if (val == 1) {
      return true;
    }
    return true;
  }

  int boolToInt(bool val) {
    if (val == true) {
      return 1;
    } else if (val == false) {
      return 0;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Stack(
        children: [
          FutureBuilder<constructorGeneratedTrainingModel>(
            future: genTrenModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                    color: Colors.redAccent,
                    child: PageView.builder(
                        onPageChanged: (pageNumber) {
                          setState(() {
                            _playingIndex = pageNumber;
                          });
                        },
                        //physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.generatedTraining!.length,
                        itemBuilder: (context, index) {
                          var training =
                              snapshot.data!.generatedTraining![index];
                          var currentDesc = settingsBox.get("lang") == 0
                              ? training.exDesc
                              : training.exDescEn;

                          return ItemWidget(
                            index: index,
                            playingIndex: _playingIndex,
                            desc: currentDesc ?? '',
                            videoUrl: training.exVideoUrl ?? '',
                            onPlayButtonPressed: () {
                              setState(() {
                                _playingIndex = index;
                              });
                            },
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
            },
          ),
          Positioned(
            left: 20,
            top: 50,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: GlassContainer(
                height: 50,
                width: 50,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.40),
                    Colors.white.withOpacity(0.10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.60),
                    Colors.white.withOpacity(0.10),
                    Colors.red.withOpacity(0.05),
                    Colors.red.withOpacity(0.60),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.39, 0.40, 1.0],
                ),
                blur: 20,
                child: Center(
                  child: Icon(Icons.arrow_back),
                ),
                borderRadius: BorderRadius.circular(24.0),
                borderWidth: 1.0,
                elevation: 3.0,
                isFrostedGlass: true,
                shadowColor: Colors.red.withOpacity(0.20),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width - 120,
            top: 50,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: FilterChip(
                  selectedColor: Colors.red,
                  label: Text(settingsBox.get("lang") == 0
                      ? "Описание"
                      : "Description"),
                  onSelected: (value) {
                    setState(() {
                      settingsBox.put("isDescOn", boolToInt(value));
                    });
                  },
                  selected: intToBool(settingsBox.get("isDescOn") ?? 1),
                ),
              ),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ],
      ),
    ));
  }
}

class ItemWidget extends StatefulWidget {
  final int playingIndex;

  final int index;

  final VoidCallback onPlayButtonPressed;

  final String desc;

  final String videoUrl;

  const ItemWidget({
    Key? key,
    required this.playingIndex,
    required this.index,
    required this.videoUrl,
    required this.desc,
    required this.onPlayButtonPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ItemWidgetState();
  }
}

class ItemWidgetState extends State<ItemWidget>
    with AutomaticKeepAliveClientMixin {
  BetterVideoPlayerController playerController = BetterVideoPlayerController();

  late Box<int> settingsBox;

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  @override
  void initState() {
    super.initState();
    initHive();
    settingsBox = Hive.box<int>("Settings");
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.playingIndex == oldWidget.index &&
        widget.playingIndex != widget.index) {
      final oldPlayerController = playerController;
      Future.delayed(Duration(milliseconds: 100), () {
        oldPlayerController.dispose();
      });
      playerController = BetterVideoPlayerController();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () {
        if (playerController.videoPlayerValue!.isPlaying) {
          playerController.pause();
        } else {
          playerController.play();
        }
      },
      child: AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // play button
            if (widget.playingIndex != widget.index)
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    constraints: BoxConstraints.tightFor(width: 60, height: 60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black26,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  onPressed: widget.onPlayButtonPressed,
                ),
              ),
            // video player
            if (widget.playingIndex == widget.index)
              BetterVideoPlayer(
                controller: playerController,
                dataSource: BetterVideoPlayerDataSource(
                  BetterVideoPlayerDataSourceType.network,
                  widget.videoUrl,
                ),
                configuration: BetterVideoPlayerConfiguration(
                    autoPlay: true, looping: true),
              ),
            if (settingsBox.get("isDescOn") == 1)
              Align(
                child: Padding(
                  child: Text(
                    widget.desc,
                    style:
                        TextStyle(fontWeight: ui.FontWeight.bold, fontSize: 17),
                  ),
                  padding: EdgeInsets.only(bottom: 44, left: 12, right: 12),
                ),
                alignment: Alignment.bottomLeft,
              )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.playingIndex == widget.index;
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {required this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}

//List<String> toStrList(List<String?> listq) => List.from(listq);















