

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class RepairerModel {

  final String id;
  final String name;
  final String nameComplement;
  final String adress1;
  final String adress2;
  final String adress3;
  final String city;
  final String cp;
  final String phone;
  final String fax;
  final String mail;
  final String latitude;
  final String longitude;
  final String infos1;
  final String infos2;
  final String infos3;

  RepairerModel(this.id, this.name,this.nameComplement, this.adress1, this.adress2, this.adress3, this.city, this.cp, this.phone, this.fax, this.mail, this.latitude, this.longitude, this.infos1, this.infos2, this.infos3);

  factory RepairerModel.fromJson(Map<String, dynamic> parsedJson){
    return RepairerModel(
      parsedJson['idReparateur'],
      parsedJson['nomReparateur'],
      parsedJson['complementReparateur'],
      parsedJson['adresse1Reparateur'],
      parsedJson['adresse2Reparateur'],
      parsedJson['adresse3Reparateur'],
      parsedJson['villeReparateur'],
      parsedJson['codePostalReparateur'],
      parsedJson['telephoneReparateur'],
      parsedJson['faxReparateur'],
      parsedJson['emailReparateur'],
      parsedJson['latitudeReparateur'],
      parsedJson['longitudeReparateur'],
      parsedJson['infosOuverture1'],
      parsedJson['infosOuverture2'],
      parsedJson['infosOuverture3']
    );
  }
}
  
class RepairerMarker extends Marker {
  RepairerMarker({@required this.repairerModel})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: 200.0,
          width: 200.0,
          point: LatLng(double.parse(repairerModel.latitude), double.parse(repairerModel.longitude)),
          builder: (BuildContext ctx) => IconButton(
            icon: Image(image: AssetImage('assets/pin-black.png')), 
            onPressed: null
            )
        );

  final RepairerModel repairerModel;
}


