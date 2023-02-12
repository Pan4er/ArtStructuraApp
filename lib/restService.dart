import 'package:artstruktura/models/healthCatModel.dart';
import 'package:artstruktura/models/healthExercisesModel.dart';
import 'package:artstruktura/models/healthModel.dart';
import 'package:artstruktura/models/musicCatModel.dart';
import 'package:artstruktura/models/musicModel.dart';
import 'package:artstruktura/models/traingCatModel.dart';
import 'package:artstruktura/models/constructorCatModel.dart';
import 'package:http/http.dart' as http;
import 'models/trainingExercisesModel.dart';
import 'models/trainingsModel.dart';
import 'dart:convert';

class RestService {
  static Future<TrainingsModel> getTrainings(int limit, String word) async {
    var client = http.Client();
    var url;
    if (word == "") {
      url = Uri.http("51.250.39.117:8000", "/trainingsAll/${limit}");
    } else {
      url = Uri.http("51.250.39.117:8000", "/trainingsByWord/${word}/${limit}");
    }

    var trainingsModel =
        TrainingsModel(trainings: [Trainings(trainingName: "Error", id: -404)]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var trainingsModel = TrainingsModel.fromJson(jsonMap);
        client.close();
        return trainingsModel;
      }
    } catch (Exc) {
      client.close();
      return TrainingsModel(
          trainings: [Trainings(trainingName: "Error", id: -404)]);
    }
    client.close();
    return trainingsModel;
  }

  static Future<TrainingCat> getTrainingCategories() async {
    var client = http.Client();
    var url = Uri.http("51.250.39.117:8000", "/categories");
    var trainingCatModel =
        TrainingCat(categories: [Categories(categorieName: "Error")]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var trainingCatModel = TrainingCat.fromJson(jsonMap);
        client.close();
        return trainingCatModel;
      }
    } catch (Exc) {
      client.close();
      return TrainingCat(categories: [Categories(categorieName: "Error")]);
    }
    client.close();
    return trainingCatModel;
  }

  static Future<TrainingsModel> getTrainingByCategorie(int categorieId) async {
    var client = http.Client();
    var url = Uri.http(
        "51.250.39.117:8000", "/trainingsByCategorie/${categorieId}/1000");
    var trainingsModel =
        TrainingsModel(trainings: [Trainings(trainingName: "Error", id: -404)]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var trainingsModel = TrainingsModel.fromJson(jsonMap);
        client.close();
        return trainingsModel;
      }
    } catch (Exc) {
      client.close();
      return TrainingsModel(
          trainings: [Trainings(trainingName: "Error", id: -404)]);
    }
    client.close();
    return trainingsModel;
  }

  static Future<TrainingExModel> getTrainingExercises(int trainingId) async {
    var client = http.Client();
    var url = Uri.http("51.250.39.117:8000", "/excersises/${trainingId}");
    var exersisesModel =
        TrainingExModel(excersises: [Excersises(exName: "Error")]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var exersisesModel = TrainingExModel.fromJson(jsonMap);
        client.close();
        return exersisesModel;
      }
    } catch (Exc) {
      client.close();
      return TrainingExModel(excersises: [Excersises(exName: "Error")]);
    }
    client.close();
    return exersisesModel;
  }

  //-------------------------------------------------HEALTH

  static Future<HealthModel> getHealth(int limit, String word) async {
    var client = http.Client();
    var url;
    if (word == "") {
      url = Uri.http("51.250.39.117:8000", "/healthAll/${limit}");
    } else {
      url = Uri.http("51.250.39.117:8000", "/healthByWord/${word}/${limit}");
    }

    var healthModel =
        HealthModel(healthList: [HealthList(healthName: "Error", id: -404)]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var healthModel = HealthModel.fromJson(jsonMap);
        client.close();
        return healthModel;
      }
    } catch (Exc) {
      client.close();
      return HealthModel(
          healthList: [HealthList(healthName: "Error", id: -404)]);
    }
    client.close();
    return healthModel;
  }

  static Future<HealthCat> getHealthCategories() async {
    var client = http.Client();
    var url = Uri.http("51.250.39.117:8000", "/healthCategories");
    var healthCatModel =
        HealthCat(healthCategories: [HealthCategories(categorieName: "Error")]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var healthCatModel = HealthCat.fromJson(jsonMap);
        client.close();
        return healthCatModel;
      }
    } catch (Exc) {
      client.close();
      return HealthCat(
          healthCategories: [HealthCategories(categorieName: "Error")]);
    }
    client.close();
    return healthCatModel;
  }

  static Future<HealthModel> getHealthByCategorie(int categorieId) async {
    var client = http.Client();
    var url = Uri.http(
        "51.250.39.117:8000", "/healthByCategorie/${categorieId}/1000");
    var healthModel =
        HealthModel(healthList: [HealthList(healthName: "Error", id: -404)]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var healthModel = HealthModel.fromJson(jsonMap);
        client.close();
        return healthModel;
      }
    } catch (Exc) {
      client.close();
      return HealthModel(
          healthList: [HealthList(healthName: "Error", id: -404)]);
    }
    client.close();
    return healthModel;
  }

  static Future<HealthExModel> getHealthExercises(int healthId) async {
    var client = http.Client();
    var url = Uri.http("51.250.39.117:8000", "/healthExcersises/${healthId}");
    var hexersisesModel =
        HealthExModel(healthExcersises: [HealthExcersises(hExName: "Error")]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var hexersisesModel = HealthExModel.fromJson(jsonMap);
        client.close();
        return hexersisesModel;
      }
    } catch (Exc) {
      client.close();
      return HealthExModel(
          healthExcersises: [HealthExcersises(hExName: "Error")]);
    }
    client.close();
    return hexersisesModel;
  }

  static Future<MusicCat> getMusicCategories() async {
    var client = http.Client();
    var url = Uri.http("51.250.39.117:8000", "/musicCategories");
    var musicCatModel =
        MusicCat(musicCategories: [MusicCategories(categorieName: "Error")]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var musicCatModel = MusicCat.fromJson(jsonMap);
        client.close();
        return musicCatModel;
      }
    } catch (Exc) {
      client.close();
      return MusicCat(
          musicCategories: [MusicCategories(categorieName: "Error")]);
    }
    client.close();
    return musicCatModel;
  }

  static Future<Music> getMusicByCategorie(int categorieId) async {
    var client = http.Client();
    var url =
        Uri.http("51.250.39.117:8000", "/musicByCategorie/${categorieId}/1000");
    var music = Music(tracksList: [TracksList(trackName: "Error", id: -404)]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var music = Music.fromJson(jsonMap);
        client.close();
        return music;
      }
    } catch (Exc) {
      client.close();
      return Music(tracksList: [TracksList(trackName: "Error", id: -404)]);
    }
    client.close();
    return music;
  }

  static Future<constructorCatModel> getConstructorCategories() async {
    var client = http.Client();
    var url = Uri.http("51.250.39.117:8000", "/constructorCategories");
    var constCatModel = constructorCatModel(
        constructorCategories: [ConstructorCategories(constName: "Error")]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var constCatModel = constructorCatModel.fromJson(jsonMap);
        client.close();
        return constCatModel;
      }
    } catch (Exc) {
      client.close();
      return constructorCatModel(
          constructorCategories: [ConstructorCategories(constName: "Error")]);
    }
    client.close();
    return constCatModel;
  }
}
