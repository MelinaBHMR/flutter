
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openstreetmap_project/presentation/widgets/tabbed_appbar_widget.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabbedAppBarSample(),
    );
  }
}
