import 'package:artstruktura/drawer.dart';
import 'package:artstruktura/justPlayList.dart';
import 'package:artstruktura/models/musicCatModel.dart';
import 'package:artstruktura/models/musicModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:artstruktura/restService.dart';
import 'package:url_launcher/url_launcher.dart';

class Spirit extends StatefulWidget {
  const Spirit({Key? key}) : super(key: key);

  @override
  State<Spirit> createState() => _SpiritState();
}

class _SpiritState extends State<Spirit> {
  late Box<int> settingsBox;
  late Future<Music> music;
  late Future<MusicCat> categories;
  int currentCategorieId = -1;
  bool useFilter = false;
  String currentWordToSearch = "";
  Icon currentSearchIcon = Icon(Icons.search);
  @override
  void initState() {
    super.initState();
    initHive();
    settingsBox = Hive.box<int>("Settings");
    categories = RestService.getMusicCategories();
  }

  void initHive() async {
    await Hive.openBox<int>("Settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: DrawerListview()),
        appBar: AppBar(
          title: Text(settingsBox.get("lang") == 0 ? "Музыка" : "Music"),
        ),
        body: FutureBuilder<MusicCat>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                    color: Colors.redAccent,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.musicCategories!.length,
                        itemBuilder: (context, index) {
                          var categoriesList =
                              snapshot.data!.musicCategories![index];
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
    var musicByCategorie = RestService.getMusicByCategorie(categorieId);
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
                  child: FutureBuilder<Music>(
                    future: musicByCategorie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.tracksList!.length,
                            itemBuilder: (context, index) {
                              var tracks = snapshot.data!.tracksList![index];
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
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new JustPlayList(
                                                              snapshot.data!
                                                                      .tracksList ??
                                                                  [
                                                                    TracksList(
                                                                        trackName:
                                                                            "Error",
                                                                        id: -404)
                                                                  ],
                                                              index,
                                                              categorieName)));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              child: FadeInImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    tracks.imageUrl ?? ''),
                                                placeholder: AssetImage(
                                                    "lib/img/bluredTrainig.jpg"),
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 12,
                                            left: 12,
                                            right: 12,
                                            bottom: 0),
                                        child: Text(
                                          tracks.trackName ?? '',
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 0.2,
                                              wordSpacing: 0.5,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 4,
                                            left: 12,
                                            right: 12,
                                            bottom: 0),
                                        child: Text(
                                          tracks.trackAuthor ?? '',
                                          style: TextStyle(fontSize: 14),
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

  Future refreshCategories() async {
    categories = RestService.getMusicCategories();
  }
}
