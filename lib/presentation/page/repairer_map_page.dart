 
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/data/models/Repairer_marker_model.dart';
import 'package:http/http.dart' as http;

class RepairerMapPage extends StatefulWidget {
  RepairerMapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RepairerMapPageState createState() => _RepairerMapPageState();
}

class _RepairerMapPageState extends State<RepairerMapPage> {

  Future<List<RepairerModel>> futureRepairerModel;

  @override
  void initState(){
    super.initState();
    futureRepairerModel = fetchRepairer();
  }
      
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: new MapOptions(
        plugins: [
          MarkerClusterPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          size: Size(40, 40),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: markers,
          builder: (context, markers) {
            return FloatingActionButton(
              child: Text(markers.length.toString()),
              onPressed: null,
            );
          },
        ),
      ],
    );
  }

  String name, username, avatar;
  bool isData = false;
  List<RepairerModel> repairerInfos =[];


  Future<List<RepairerModel>> fetchRepairer() async {
    final response = await http.get('http://my-json-server.typicode.com/melinaBHMR/flutter_openstreetmap_project/db');

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJSON = json.decode(response.body);
      
      responseJSON.forEach((key, value) {
        List<dynamic> reparators = value;
        reparators.forEach((element) {
        Map<String, dynamic> reparatorInfo = element;  
          repairerInfos.add(RepairerModel.fromJson(reparatorInfo));
        });
      });
      return repairerInfos;
    } else {
      throw Exception('Failed to load RepairerModel');
    }
  }

}


/*
 Widget build(BuildContext context) {
    return FlutterMap(
      options: new MapOptions(
        plugins: [
          MarkerClusterPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          size: Size(40, 40),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: markers,
          polygonOptions: PolygonOptions(
              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 3),
          builder: (context, markers) {
            return FloatingActionButton(
              child: Text(markers.length.toString()),
              onPressed: null,
            );
          },
        ),
      ],
    );
  }*/