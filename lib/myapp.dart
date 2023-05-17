import 'package:flutter/material.dart';
import 'package:ovision/controllers/cadastro.dart';
import 'package:ovision/views/home/home.dart';
import 'package:ovision/views/gallery.dart';
import 'package:ovision/views/photo_library.dart';
import 'views/foto.dart';
import 'controllers/login.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ovision",
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          elevation: 0
        ),
      ),
      debugShowCheckedModeBanner: false,
      
      initialRoute: '/',
      
      routes: {
        '/' :(context) => const Login(),
        '/home' :(context) => const Home(),
        '/fotos' :(context) => const Fotos(),
        '/cadastro':(context) => const Cadastro(),

        '/gallery' :(context) => Galeria(),
        '/library' :(context) => const Library()
      }
    );
  }
}
