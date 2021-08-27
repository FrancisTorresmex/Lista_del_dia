import 'package:flutter/material.dart';
import 'package:tusdeberes/pages/add_page.dart';
import 'package:tusdeberes/pages/edit_page.dart';
import 'package:tusdeberes/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home_page',
      routes: {
        'home_page': (BuildContext context) => HomePage(),
        'add_page' : (BuildContext context) => AddPage(),
        'edit_page': (BuildContext context) => EditPage(),
      },
    );
  }
}