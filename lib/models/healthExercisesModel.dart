class HealthExModel {
  List<HealthExcersises>? healthExcersises;

  HealthExModel({this.healthExcersises});

  HealthExModel.fromJson(Map<String, dynamic> json) {
    if (json['healthExcersises'] != null) {
      healthExcersises = <HealthExcersises>[];
      json['healthExcersises'].forEach((v) {
        healthExcersises!.add(new HealthExcersises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthExcersises != null) {
      data['healthExcersises'] =
          this.healthExcersises!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthExcersises {
  String? hExName;
  String? hExComment;
  String? hExRestTime;
  String? hExStartTime;
  String? hExThumbnailUrl;
  String? hExNameEn;
  String? hExCommentEn;
  String? hExRestTimeEn;

  HealthExcersises(
      {this.hExName,
      this.hExComment,
      this.hExRestTime,
      this.hExStartTime,
      this.hExThumbnailUrl,
      this.hExNameEn,
      this.hExCommentEn,
      this.hExRestTimeEn});

  HealthExcersises.fromJson(Map<String, dynamic> json) {
    hExName = json['h_ex_name'];
    hExComment = json['h_ex_comment'];
    hExRestTime = json['h_ex_rest_time'];
    hExStartTime = json['h_ex_start_time'];
    hExThumbnailUrl = json['h_ex_thumbnail_url'];
    hExNameEn = json['h_ex_name_en'];
    hExCommentEn = json['h_ex_comment_en'];
    hExRestTimeEn = json['h_ex_rest_time_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_ex_name'] = this.hExName;
    data['h_ex_comment'] = this.hExComment;
    data['h_ex_rest_time'] = this.hExRestTime;
    data['h_ex_start_time'] = this.hExStartTime;
    data['h_ex_thumbnail_url'] = this.hExThumbnailUrl;
    data['h_ex_name_en'] = this.hExNameEn;
    data['h_ex_comment_en'] = this.hExCommentEn;
    data['h_ex_rest_time_en'] = this.hExRestTimeEn;
    return data;
  }
}
