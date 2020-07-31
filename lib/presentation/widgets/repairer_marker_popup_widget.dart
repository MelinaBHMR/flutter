
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openstreetmap_project/data/models/repairer_marker_model.dart';

class RepairerMarkerPopup extends StatelessWidget {
  const RepairerMarkerPopup({Key key, this.repairer}) : super(key: key);
  final RepairerModel repairer;

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: 200,
          margin: const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: (){
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.white,
                    child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,  
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            repairer.name+' '+isNull(repairer.nameComplement),
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            repairer.adress1.toLowerCase()+isNull(repairer.adress2)+isNull(repairer.adress3),
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black
                              ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            isNull(repairer.cp)+isNull(repairer.city),
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            repairer.infos1+isNull(repairer.infos2)+isNull(repairer.infos3),
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey
                              ),
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ]
                      )
                  );
                }
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${isNull(repairer.name)} ${isNull(repairer.nameComplement)}',             
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,),
                  Text('${isNull(repairer.adress1)} ${isNull(repairer.adress2)} ${isNull(repairer.adress2)},',           
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    textAlign: TextAlign.left,),
                  Text('${isNull(repairer.cp)} ${isNull(repairer.city)}',             
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    textAlign: TextAlign.left,),
                ],
              ),
            ),
          ),
        )
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