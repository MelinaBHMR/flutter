import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_openstreetmap_project/presentation/page/repairer_list_page.dart';
import 'package:flutter_openstreetmap_project/presentation/page/repairer_map_page.dart';


class TabbedAppBarSample extends StatefulWidget {
  TabbedAppBarSample({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TabbedAppBarSampleState createState() => _TabbedAppBarSampleState();
}

class _TabbedAppBarSampleState extends State<TabbedAppBarSample> with SingleTickerProviderStateMixin {
  
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: choices.length);
  }

   @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('Choisissez votre réparateur'),
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back), 
              onPressed: (){
                Navigator.pop(context);
              }),
          ),
          body : Scaffold(
              appBar :PreferredSize(
                preferredSize:  Size.fromHeight(60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 72.5),
                        controller: _tabController,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.red,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 4.0,
                        labelColor: Colors.red,
                        labelStyle:
                          TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                        isScrollable: true,
                        tabs: choices.map<Tab>((Choice choice) {
                          return 
                            Tab(
                              text: choice.title,
                            );
                        }).toList(),
                      ),
                    ],
                  )
                ),
              body : TabBarView(
                controller: _tabController,
                children: choices.map<Widget>((Choice choice) {
                return ChoiceCard(choice: choice);
                  }).toList(),
              )
            ),
      ));
  }
} 

  


class Choice {
  const Choice({this.title, this.color});
  final num color;
  final String title;
}


const List<Choice> choices = <Choice>[
  Choice(title: 'Carte'),
  Choice(title: 'Liste'),
];
     

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    if(choice.title == 'Carte'){
      return RepairerMapPage();
    }else{
      return RepairerListPage();
    }
    
  }
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}
