import 'package:flutter/material.dart';
import 'package:pinterest/src/pinterest_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseñps App',
      home: PinterestPage()
      
    );
  }
}
