class HealthModel {
  List<HealthList>? healthList;

  HealthModel({this.healthList});

  HealthModel.fromJson(Map<String, dynamic> json) {
    if (json['healthList'] != null) {
      healthList = <HealthList>[];
      json['healthList'].forEach((v) {
        healthList!.add(new HealthList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthList != null) {
      data['healthList'] = this.healthList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthList {
  int? id;
  String? healthName;
  String? imageUrl;
  String? videoUrl;
  int? hCategorieId;
  String? healthComment;
  String? healthNameEn;
  String? healthCommentEn;

  HealthList(
      {this.id,
      this.healthName,
      this.imageUrl,
      this.videoUrl,
      this.hCategorieId,
      this.healthComment,
      this.healthNameEn,
      this.healthCommentEn});

  HealthList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    healthName = json['health_name'];
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    hCategorieId = json['hCategorie_id'];
    healthComment = json['health_comment'];
    healthNameEn = json['health_name_en'];
    healthCommentEn = json['health_comment_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['health_name'] = this.healthName;
    data['image_url'] = this.imageUrl;
    data['video_url'] = this.videoUrl;
    data['hCategorie_id'] = this.hCategorieId;
    data['health_comment'] = this.healthComment;
    data['health_name_en'] = this.healthNameEn;
    data['health_comment_en'] = this.healthCommentEn;
    return data;
  }
}
