class Music {
  List<TracksList>? tracksList;

  Music({this.tracksList});

  Music.fromJson(Map<String, dynamic> json) {
    if (json['tracksList'] != null) {
      tracksList = <TracksList>[];
      json['tracksList'].forEach((v) {
        tracksList!.add(new TracksList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tracksList != null) {
      data['tracksList'] = this.tracksList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TracksList {
  int? id;
  String? trackName;
  String? trackAuthor;
  int? categorieId;
  String? audioUrl;
  String? imageUrl;

  TracksList(
      {this.id,
      this.trackName,
      this.trackAuthor,
      this.categorieId,
      this.audioUrl,
      this.imageUrl});

  TracksList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackName = json['track_name'];
    trackAuthor = json['track_author'];
    categorieId = json['categorie_id'];
    audioUrl = json['audio_url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['track_name'] = this.trackName;
    data['track_author'] = this.trackAuthor;
    data['categorie_id'] = this.categorieId;
    data['audio_url'] = this.audioUrl;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
