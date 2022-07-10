class TrainingCat {
  List<Categories>? categories;

  TrainingCat({this.categories});

  TrainingCat.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? categorieName;
  String? categorieNameEn;

  Categories({this.id, this.categorieName, this.categorieNameEn});

  Categories.fromJson(Map<String, dynamic> json) {
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
