class TrainingExModel {
  List<Excersises>? excersises;

  TrainingExModel({this.excersises});

  TrainingExModel.fromJson(Map<String, dynamic> json) {
    if (json['excersises'] != null) {
      excersises = <Excersises>[];
      json['excersises'].forEach((v) {
        excersises!.add(new Excersises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.excersises != null) {
      data['excersises'] = this.excersises!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Excersises {
  String? exName;
  String? exTrainComment;
  String? exRestTime;
  String? exStartTime;
  String? exThumbnailUrl;
  String? exNameEn;
  String? exTrainCommentEn;
  String? exRestTimeEn;

  Excersises(
      {this.exName,
      this.exTrainComment,
      this.exRestTime,
      this.exStartTime,
      this.exThumbnailUrl,
      this.exNameEn,
      this.exTrainCommentEn,
      this.exRestTimeEn});

  Excersises.fromJson(Map<String, dynamic> json) {
    exName = json['ex_name'];
    exTrainComment = json['ex_train_comment'];
    exRestTime = json['ex_rest_time'];
    exStartTime = json['ex_start_time'];
    exThumbnailUrl = json['ex_thumbnail_url'];
    exNameEn = json['ex_name_en'];
    exTrainCommentEn = json['ex_train_comment_en'];
    exRestTimeEn = json['ex_rest_time_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ex_name'] = this.exName;
    data['ex_train_comment'] = this.exTrainComment;
    data['ex_rest_time'] = this.exRestTime;
    data['ex_start_time'] = this.exStartTime;
    data['ex_thumbnail_url'] = this.exThumbnailUrl;
    data['ex_name_en'] = this.exNameEn;
    data['ex_train_comment_en'] = this.exTrainCommentEn;
    data['ex_rest_time_en'] = this.exRestTimeEn;
    return data;
  }
}
