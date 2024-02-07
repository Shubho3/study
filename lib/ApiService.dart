import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'MasterData.dart';

class ApiService {
  static Future<List<MasterData>> fetchMasterData() async {
    List<MasterData> m = [];
    var response = await getData("https://dummyjson.com/users");
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
        log('the response for url:  is ${jsonResponse}');
        //var data  = MasterData.fromJson(jsonResponse);
      List<MasterData> intList = [
        MasterData(id: 1,name: "shubh"),
        MasterData(id: 2,name: "shubh2"),
        MasterData(id: 3,name: "shubh3"),
        MasterData(id: 4,name: "shubh4"),
        MasterData(id: 5,name: "shubh5"),
      ];

      return intList;
    }
    List<MasterData> intList = [
      MasterData(id: 1,name: "shubh"),
      MasterData(id: 2,name: "shubh2"),
      MasterData(id: 3,name: "shubh3"),
      MasterData(id: 4,name: "shubh4"),
      MasterData(id: 5,name: "shubh5"),
    ];
    return intList;
  }

  static Future<http.Response> getData(String url) async {
    http.Response response =
        http.Response('{"message":"failure","status":0}', 404);
    log('called $url');
    try {
      response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode != 200) {
        print('The response status for url $url is ${response.statusCode}');
      }
    } catch (e) {
      log('Error in $url : ------ $e');
    }
    return response;
  }
}
