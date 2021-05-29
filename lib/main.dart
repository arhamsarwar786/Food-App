import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'splash.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox("favBox");
  await Hive.openBox("allKeys");
  await Hive.openBox("addToCart");
  await Hive.openBox("addKeys");
  await Hive.openBox("hKeys");
  await Hive.openBox("hValues");
  runApp(MyApp());
  //  Admob.initialize("com.example.food_app1");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: redTheme,
        fontFamily: "ubuntu",
      ),
      home: Splash(),
    );
  }
}