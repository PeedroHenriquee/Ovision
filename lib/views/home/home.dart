import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Image.asset('images/as.png'),
              ),
              SizedBox(height: 70.0),
              Column(
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(160,
                        130)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                        shape:
                        MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/fotos'),
                      child: Column(
                        children: [
                          Text('Camera'),
                          SizedBox(height: 10),
                          Icon(Icons.camera_alt)
                        ],
                      )),

                  SizedBox(height: 30),

                  ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(160,
                        130)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                        shape:
                        MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/gallery'),
                      child: Column(
                        children: [
                          Text('Galeria'),
                          SizedBox(height: 10),
                          Icon(Icons.photo_library)
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
