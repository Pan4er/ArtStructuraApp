class constructorGeneratedTrainingModel {
  List<GeneratedTraining>? generatedTraining;

  constructorGeneratedTrainingModel({this.generatedTraining});

  constructorGeneratedTrainingModel.fromJson(Map<String, dynamic> json) {
    if (json['generatedTraining'] != null) {
      generatedTraining = <GeneratedTraining>[];
      json['generatedTraining'].forEach((v) {
        generatedTraining!.add(new GeneratedTraining.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generatedTraining != null) {
      data['generatedTraining'] =
          this.generatedTraining!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneratedTraining {
  String? exDesc;
  String? exVideoUrl;
  String? exDescEn;

  GeneratedTraining({this.exDesc, this.exVideoUrl, this.exDescEn});

  GeneratedTraining.fromJson(Map<String, dynamic> json) {
    exDesc = json['ex_desc'];
    exVideoUrl = json['ex_video_url'];
    exDescEn = json['ex_desc_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ex_desc'] = this.exDesc;
    data['ex_video_url'] = this.exVideoUrl;
    data['ex_desc_en'] = this.exDescEn;
    return data;
  }
}
