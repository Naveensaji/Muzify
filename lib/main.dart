
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:muzify/models/box_class.dart';
import 'package:muzify/splashscreen.dart';

import 'models/hivemodel.dart';


Future<void>main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalsongsAdapter());
  await Hive.openBox<List>(boxname);
   final box = Boxes.getinstance();

   
  List? favoritekeys1 = box.keys.toList();
  if (!favoritekeys1.contains('favorites')) {
    List<dynamic> favoritelist = [];
    box.put('favorites', favoritelist);
  }
 


  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music player',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home:SplashScreen(),
    );
  }
}