class TrainingsModel {
  List<Trainings>? trainings;

  TrainingsModel({this.trainings});

  TrainingsModel.fromJson(Map<String, dynamic> json) {
    if (json['trainings'] != null) {
      trainings = <Trainings>[];
      json['trainings'].forEach((v) {
        trainings!.add(new Trainings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trainings != null) {
      data['trainings'] = this.trainings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trainings {
  int? id;
  String? trainingName;
  String? imageUrl;
  String? videoUrl;
  int? categorieId;
  String? trainingComment;
  String? trainingNameEn;
  String? trainingCommentEn;

  Trainings(
      {this.id,
      this.trainingName,
      this.imageUrl,
      this.videoUrl,
      this.categorieId,
      this.trainingComment,
      this.trainingNameEn,
      this.trainingCommentEn});

  Trainings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainingName = json['training_name'];
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    categorieId = json['categorie_id'];
    trainingComment = json['training_comment'];
    trainingNameEn = json['training_name_en'];
    trainingCommentEn = json['training_comment_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['training_name'] = this.trainingName;
    data['image_url'] = this.imageUrl;
    data['video_url'] = this.videoUrl;
    data['categorie_id'] = this.categorieId;
    data['training_comment'] = this.trainingComment;
    data['training_name_en'] = this.trainingNameEn;
    data['training_comment_en'] = this.trainingCommentEn;
    return data;
  }
}
