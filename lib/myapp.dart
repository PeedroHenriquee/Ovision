import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovision/controllers/cadastro.dart';
import 'package:ovision/views/gallery.dart';
import 'package:ovision/views/home/home.dart';
import 'package:ovision/views/photo_library.dart';
import 'views/foto.dart';
import 'controllers/login.dart';


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
        '/' :(context) => Login(),
        '/home' :(context) => Home(),
        '/fotos' :(context) => Fotos(),
        '/cadastro':(context) => Cadastro(title: 'cadastro'),
        '/gallery' :(context) => Galeria(),
        '/library' :(context) => Library()
      }
    );
  }
}
