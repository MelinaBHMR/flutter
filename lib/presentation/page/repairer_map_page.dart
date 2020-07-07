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
   // setCustomMapPin();
  }

  MapController mapController = MapController();
  StreamController<LatLng> markerlocationStream = StreamController();
  UserLocationOptions userLocationOptions;
  String name, username, avatar;
  bool isData = false;
  List<RepairerModel> repairerInfos =[];
  List<Marker> markers = [];
 // BitmapDescriptor pinLocationIcon;
  Uint8List markerIcon;
  var infoWindowVisible = false;

 /* void setCustomMapMarker(Marker marker) async {
    if(marker.isSelected == true){
      markerIcon = await getBytesFromAsset('assets\pin-red.png', 100);
    }
   }*/

      
  @override
  Widget build(BuildContext context) {
    markerlocationStream.stream.listen((onData) {
      // print(onData.latitude);
    });
    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: mapController,
        markers: markers,
        onLocationUpdate: (LatLng pos) =>
            print("onLocationUpdate ${pos.toString()}"),
        updateMapLocationOnPositionChange: false,
        showMoveToCurrentLocationFloatingActionButton: true,
        zoomToCurrentLocationOnLoad: true,
        fabBottom: 50,
        fabRight: 50,
        verbose: false);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Choisissez votre réparateur'),
        centerTitle: true),
      body: new FlutterMap(
        options: new MapOptions(
          minZoom: 1.0,
          //center: new LatLng(48.853853, 2.293718),
          plugins: [
            UserLocationPlugin(),
          ],
          interactive: true,
          onTap: (_) => _popupLayerController.hidePopup(),
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          new MarkerLayerOptions(
            markers: markers,
          ),
          userLocationOptions
        ],
        mapController: mapController,
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(onPressed: null, heroTag: 1),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(onPressed: null, heroTag: 2,),
            ),
        ],
      )
      /*floatingActionButton: Image.asset('assets/repair-btn-current-location.png'),// MARCHE MAIS QUE POUR UN FLOATING BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,*/
    );
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
      markers.add(new Marker(
        point: new LatLng(double.parse(element.latitude), double.parse(element.longitude)),
        width: 200.0,
        height: 200.0,
        builder: (context) => 
          IconButton(
            icon: Image(image: AssetImage('assets/pin-black.png')), 
            onPressed: () { 
              IconButton(
                icon: Image(image: AssetImage('assets/pin-red.png')), 
                onPressed: () => new PopupMarkerLayerOptions(
                  popupBuilder: (context, Marker marker) { 
                    return new RepairerMarkerPopup(repairer: element);
                  },
                ));
            },)
      ));
    });
    print(markers);
  }
/*
 Stack _buildCustomMarker() {
    return Stack(
      children: <Widget>[
        popup(),
        marker(),
      ],
    );
  }

  Opacity popup() {
    return Opacity(
      opacity: infoWindowVisible ? 1.0 : 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 279.0,
        height: 256.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/ic_info_window.png"),
                fit: BoxFit.cover)),
        //child: CustomPopup(key: key),
      ),
    );
  }

  Opacity marker() {
    return Opacity(
      child: Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/pin-black.png',
            width: 49,
            height: 65,
          )),
      opacity: infoWindowVisible ? 0.0 : 1.0,
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }*/
}
