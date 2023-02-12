// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:artstruktura/models/constructorGeneratedTrainingModel.dart';

class RestServicePost {
  static Future<constructorGeneratedTrainingModel> postRequest(
      List<String> filters) async {
    //List<String> strFilters = toStrList(filters);
    final bod = jsonEncode({"tags": filters});

    var client = http.Client();
    try {
      var response =
          await client.post(Uri.http('51.250.39.117:8000', '/constructor'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: bod);

      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      var Model = constructorGeneratedTrainingModel.fromJson(jsonMap);
      client.close();
      return Model;
    } catch (e) {
      client.close();
      return constructorGeneratedTrainingModel(
          generatedTraining: [GeneratedTraining(exDesc: "Error")]);
    }

    //print(response.statusCode);
  }

  static List<String> toStrList(List<String?> listq) => List.from(listq);
}







/*
static Future<constructorGeneratedTrainingModel> postGenerateTraining() async {
    var client = http.Client();
    var url = Uri.http("51.250.39.117:8000", "/constructor");
    var genTrainModel = constructorGeneratedTrainingModel(
        generatedTraining:  [GeneratedTraining(exDesc: "Error")]);
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var genTrainModel = constructorGeneratedTrainingModel.fromJson(jsonMap);
        client.close();
        return genTrainModel;
      }
    } catch (Exc) {
      client.close();
      return constructorGeneratedTrainingModel(
          generatedTraining:  [GeneratedTraining(exDesc: "Error")]);
    }
    client.close();
    return genTrainModel;
  }
*/