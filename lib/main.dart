import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  //open a box
  final Box box = await Hive.openBox('mybox');

  runApp(MyApp(box: box,));
}

class MyApp extends StatelessWidget {
  final Box box;
  const MyApp({super.key, required this.box});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(box: box,),
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}
