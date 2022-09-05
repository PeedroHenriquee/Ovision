import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ovision/views/foto.dart';

class Home extends StatefulWidget {
  const Home({key, title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O-Vision'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Image.asset('images/as.jpeg'),
              ),
              SizedBox(height: 100,),
              TextField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.face_outlined),
                    hintText: "Digite Emailll"),
              ),
              SizedBox(height: 20.0),
              TextField(
                obscureText: true,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.key),
                    hintText: 'Digite Senha'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('ENTRAR'),
                
                 
                
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => fotos(title: 'fotos')));
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
