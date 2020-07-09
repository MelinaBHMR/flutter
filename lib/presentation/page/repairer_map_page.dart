import 'dart:async';
import 'dart:typed_data';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_openstreetmap_project/data/models/repairer_marker_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_openstreetmap_project/presentation/widgets/repairer_marker_popup_widget.dart';
import 'package:flutter_openstreetmap_project/presentation/widgets/tabbed_appbar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:user_location/user_location.dart';

class RepairerMapPage extends StatefulWidget {
  RepairerMapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RepairerMapPageState createState() => _RepairerMapPageState();
}

class _RepairerMapPageState extends State<RepairerMapPage> {

  final PopupController _popupLayerController = PopupController();
  Future<List<RepairerModel>> futureRepairerModel;

  @override
  void initState(){
    super.initState();
    generateMarkers();
  }

  MapController mapController = MapController();
  // ignore: close_sinks
  StreamController<LatLng> markerlocationStream = StreamController();
  UserLocationOptions userLocationOptions;
  String name, username, avatar;
  bool isData = false;
  List<RepairerModel> repairerInfos =[];
  List<Marker> markers = [];
  Uint8List markerIcon;
  var infoWindowVisible = false;
  bool popupShown = false;
 

  @override
  Widget build(BuildContext context) {

    markerlocationStream.stream.listen((onData) {});
    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: mapController,
        markers: markers,
        onLocationUpdate: (LatLng pos) =>
            print("onLocationUpdate ${pos.toString()}"),
        updateMapLocationOnPositionChange: false,
        showMoveToCurrentLocationFloatingActionButton: true,
        moveToCurrentLocationFloatingActionButton: Image.asset('assets/repair-btn-current-location.png'),
        zoomToCurrentLocationOnLoad: true,
        fabBottom: 20,
        fabRight: 20,
        fabHeight: 80,
        fabWidth: 80,
        verbose: false
    );

    return new Scaffold(
      body: new FlutterMap(
        options: new MapOptions(
          minZoom: 1.0,
          center: new LatLng(48.853853, 2.293718),
          plugins: [
            UserLocationPlugin(),
            PopupMarkerPlugin()
          ],
          interactive: true,
          onTap: (_) => _popupLayerController.hidePopup(),
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PopupMarkerLayerOptions(
          markers: markers,
          popupSnap: PopupSnap.top,
          popupController: _popupLayerController,
          popupBuilder: (_, Marker marker){
            if(marker is RepairerMarker){
              return RepairerMarkerPopup(repairer: marker.repairerModel);
            }
            return Card(child: const Text('Error : pas d\'infos disponibles'));
          },
        ),
          userLocationOptions
        ],
        //mapController: mapController,
      ),
      //floatingActionButton: Image.asset('assets/repair-zoom.png', width: 80.0,),
     // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }

  void showPopupForFirstMarker() {
    _popupLayerController.togglePopup(markers.first);
  }

  Future<List<RepairerModel>> fetchRepairer() async {
    final response = await http.get('http://my-json-server.typicode.com/melinaBHMR/flutter_openstreetmap_project/db');

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJSON = json.decode(response.body);
      
      responseJSON.forEach((key, value) {
        List<dynamic> reparators = value;
        reparators.forEach((element) {
        Map<String, dynamic> reparatorInfo = element;  
          repairerInfos.add(RepairerModel.fromJson(reparatorInfo));
          print(reparatorInfo);
        });
      });
      return repairerInfos;
    } else {
      throw Exception('Failed to load RepairerModel');
    }
  }

  void generateMarkers() async {
    repairerInfos = await fetchRepairer();
    repairerInfos.forEach((element){
      markers.add(new RepairerMarker(repairerModel: element));
    });
    print(markers);
  }
}
