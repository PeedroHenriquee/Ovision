import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ovision/views/cadastro.dart';
import 'package:ovision/views/foto.dart';

class Home extends StatefulWidget {
  const Home({key, title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('Voce nao tem usuario logado');
      } else {
        print('voce tem usuario logado!');
      }
    });
  }

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
                height: 200,
                child: Image.asset('images/as.jpeg'),
              ),
              SizedBox(
                height: 100,
              ),
              TextField(
                controller: _emailController,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person_rounded),
                    hintText: "Digite Email"),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _senhaController,
                obscureText: true,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.key),
                    hintText: 'Digite Senha'),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                child: Text('ENTRAR'),
                onPressed: () {
                  login();
                  
                },
                style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(120, 40)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
              ),
              SizedBox(height: 5.0,),
              ElevatedButton(
                child: Text('CADASTRAR'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cadastro(title: 'Cadastro')));
                  
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(100, 40)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _senhaController.text,
      );
      if (userCredential != null) {
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => fotos(title: 'fotos')));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Usuário nao encontrado"),
          backgroundColor: Colors.redAccent,
        ),);
      } else if (e.code == 'wrong password') {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sua senha está errada"),
          backgroundColor: Colors.redAccent,
        ),
        );
      }
    }
  }
}





