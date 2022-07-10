class MusicCat {
  List<MusicCategories>? musicCategories;

  MusicCat({this.musicCategories});

  MusicCat.fromJson(Map<String, dynamic> json) {
    if (json['musicCategories'] != null) {
      musicCategories = <MusicCategories>[];
      json['musicCategories'].forEach((v) {
        musicCategories!.add(new MusicCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.musicCategories != null) {
      data['musicCategories'] =
          this.musicCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MusicCategories {
  int? id;
  String? categorieName;
  String? categorieNameEn;

  MusicCategories({this.id, this.categorieName, this.categorieNameEn});

  MusicCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categorieName = json['categorie_name'];
    categorieNameEn = json['categorie_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categorie_name'] = this.categorieName;
    data['categorie_name_en'] = this.categorieNameEn;
    return data;
  }
}
