import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovision/views/cadastro.dart';
import 'fotoo.dart';
import 'myhomepage.dart';


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _inicializacao =  Firebase.initializeApp();

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          elevation: 0
        ),
        
      ),
     
      debugShowCheckedModeBanner: false,
      title: "Ovision",
      
      initialRoute: '/',
      
      routes: {
        
        '/' :(context) => Home (title: 'principal'),
        '/fotos' :(context) => Fotos(),
        '/cadastro':(context) => Cadastro(title: 'cadastro'),
      }
    );
  }
}
