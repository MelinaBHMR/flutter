import 'dart:convert';
import 'dart:io';

import 'package:flutter_openstreetmap_project/data/models/repairer_marker_model.dart';
import 'package:http/http.dart' as http;


class Services {
  static const String url = 'http://my-json-server.typicode.com/melinaBHMR/flutter_openstreetmap_project/db';
    
  static Future<List<RepairerModel>> getRepairersFromJson() async{

    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {    
        List<RepairerModel> repairerInfos = parseRepairers(response.body); 
        return repairerInfos;
      }else{
        throw Exception("error");
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  static List<RepairerModel>  parseRepairers (String reponseBody){
      Map<String, dynamic> responseJSON = json.decode(reponseBody);
      final List<RepairerModel> parsed = [];
      responseJSON.forEach((key, value) {
        List<dynamic> repairers = value;
        repairers.forEach((element) {
        Map<String, dynamic> repairersMap = element;  
          parsed.add(RepairerModel.fromJson(repairersMap));
        });
      });
     return parsed;
  }

  
 static Future<bool> checkConnectivity() async {
    bool connect;
    try {
      final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connect = true;
    }
    } on SocketException catch (_) {
      connect = false;
    }
    return connect;
  }
  

}