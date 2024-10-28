import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data_screen.dart'; // Importa a tela principal

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Firestore',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DataScreen(), // Tela principal
      debugShowCheckedModeBanner: false,
    );
  }
}
