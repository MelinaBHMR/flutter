import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_openstreetmap_project/presentation/page/repairer_list_page.dart';
import 'package:flutter_openstreetmap_project/presentation/page/repairer_map_page.dart';

class TabbedAppBarSample extends StatelessWidget {

  const TabbedAppBarSample({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: new Text('Choisissez votre réparateur'),
            centerTitle: true,
            leading: new BackButton(),
          ),
          body: Scaffold(
            appBar: new PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: new Container(
                color: Colors.brown[50],
                child: new SafeArea(
                 child: Column(
                   children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      labelStyle: Theme.of(context).textTheme.headline6,
                      isScrollable: true,
                      tabs: choices.map<Widget>((Choice choice) {
                        return Tab(
                          text: choice.title,
                        );
                      }).toList(),
                    ),
                   ]
                 )
                )
              ),
            ),
            body: TabBarView(
              children: choices.map<Widget>((Choice choice) {
               return ChoiceCard(choice: choice);
              }).toList(),
            ),
          )
        ),
      ),
    );
  }
}
  


class Choice {
  const Choice({this.title, this.color});
  final num color;
  final String title;
}


const List<Choice> choices = const <Choice>[
  const Choice(title: 'Carte'),
  const Choice(title: 'Liste'),
];
     

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    if(choice.title == 'Carte'){
      return MaterialApp(
        home: RepairerMapPage(),
      );
    }else {
      return MaterialApp(
        home: RepairerListPage(),
      );
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