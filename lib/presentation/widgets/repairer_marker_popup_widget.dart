
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openstreetmap_project/data/models/repairer_marker_model.dart';

class RepairerMarkerPopup extends StatelessWidget {
  const RepairerMarkerPopup({Key key, this.repairer}) : super(key: key);
  final RepairerModel repairer;

    @override
    Widget build(BuildContext context) {
      return Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('${isNull(repairer.name)} ${isNull(repairer.nameComplement)}'),
              Text('${isNull(repairer.adress1)} ${isNull(repairer.adress2)} ${isNull(repairer.adress2)},'),
              Text('${isNull(repairer.cp)} ${isNull(repairer.city)}'),
            ],
          ),
        ),
      );
    }

    String isNull(String repairerAttribute){
      if(repairerAttribute == null){
        return "";
      }else{
        return repairerAttribute;
      }
    }

  }