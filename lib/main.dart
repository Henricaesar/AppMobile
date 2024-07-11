import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:inventory/screens/splash_screen.dart';
=======
import 'screens/home_screen.dart';
>>>>>>> f339b0bd9b49d784d7662b1ad17cfdc99e1af99b

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      title: 'C_R_U_D App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Mulai dengan SplashScreen
=======
      title: 'Flutter CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
>>>>>>> f339b0bd9b49d784d7662b1ad17cfdc99e1af99b
    );
  }
}