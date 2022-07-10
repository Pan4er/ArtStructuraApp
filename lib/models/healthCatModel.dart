class HealthCat {
  List<HealthCategories>? healthCategories;

  HealthCat({this.healthCategories});

  HealthCat.fromJson(Map<String, dynamic> json) {
    if (json['healthCategories'] != null) {
      healthCategories = <HealthCategories>[];
      json['healthCategories'].forEach((v) {
        healthCategories!.add(new HealthCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthCategories != null) {
      data['healthCategories'] =
          this.healthCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthCategories {
  int? id;
  String? categorieName;
  String? categorieNameEn;

  HealthCategories({this.id, this.categorieName, this.categorieNameEn});

  HealthCategories.fromJson(Map<String, dynamic> json) {
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
