
import 'dart:async';
import 'package:flutter_openstreetmap_project/data/models/repairer_marker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openstreetmap_project/data/models/services.dart';

class RepairerListPage extends StatefulWidget {
  RepairerListPage({Key key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RepairerListPageState(); 

}

class _RepairerListPageState extends State<RepairerListPage>{
  
List<RepairerModel> repairerInfos = List();
List<RepairerModel> repairerFiltered = List();
final _debouncer = Debouncer(milliseconds: 500);

@override
  void initState(){
    super.initState();
    Services.getRepairersFromJson().then((repairersFromServer){
      setState(() {
        repairerInfos = repairersFromServer;
        repairerFiltered = repairersFromServer;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: <Widget>[
              TextField(
                cursorColor: Colors.grey[400],
                style: new TextStyle(
                  color: Colors.grey[400],
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.grey[400]),
                    hintText: "Autour de moi",
                    hintStyle: new TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                ),
                onChanged: (string){
                  _debouncer.run(() {
                    setState(() {
                      repairerFiltered = repairerInfos.where((element) => 
                      (element.name.toLowerCase().contains(string.toLowerCase()) || 
                      element.adress1.toLowerCase().contains(string.toLowerCase()) || 
                      element.cp.toString().toLowerCase().contains(string.toLowerCase()) || 
                      element.city.toLowerCase().contains(string.toLowerCase()))).toList();                 
                    });
                  });
                },
              )
            ],
          ),
        ),
        body : Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: repairerFiltered.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Row (
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                isNull(repairerFiltered[index].name),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                                ),
                              Text(
                                isNull(repairerFiltered[index].adress1).toLowerCase(),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey
                                ),
                              ),
                              Text(
                                isNull(repairerFiltered[index].cp)+isNull(repairerFiltered[index].city),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey
                                ),
                              ),
                              Text(
                              isNull(repairerFiltered[index].infos1)+isNull(repairerFiltered[index].infos2)+isNull(repairerFiltered[index].infos3),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                     )
                    ), 
                  );
                },
              ),
            ),
          ],
        ),
    );
  }

   

  
  String isNull(String repairerAttribute){
    String attribute="";
    if(repairerAttribute == null){
      return attribute;
    }else{
      return attribute = ' '+repairerAttribute;
    }
  }

}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action ){
    if(null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(microseconds: milliseconds), action);
  }
}