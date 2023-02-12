class constructorCatModel {
  List<ConstructorCategories>? constructorCategories;

  constructorCatModel({this.constructorCategories});

  constructorCatModel.fromJson(Map<String, dynamic> json) {
    if (json['constructorCategories'] != null) {
      constructorCategories = <ConstructorCategories>[];
      json['constructorCategories'].forEach((v) {
        constructorCategories!.add(new ConstructorCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.constructorCategories != null) {
      data['constructorCategories'] =
          this.constructorCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConstructorCategories {
  int? id;
  String? constName;
  String? constValue;
  String? constNameEn;

  ConstructorCategories(
      {this.id, this.constName, this.constValue, this.constNameEn});

  ConstructorCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    constName = json['constName'];
    constValue = json['constValue'];
    constNameEn = json['constNameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['constName'] = this.constName;
    data['constValue'] = this.constValue;
    data['constNameEn'] = this.constNameEn;
    return data;
  }
}
