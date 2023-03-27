import 'package:flutter/material.dart';
import 'package:weatherwj/presentation/ui/home_screen.dart';
import 'package:weatherwj/presentation/ui/splash_screen.dart';
import '';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}



