import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ovision/views/cadastro.dart';

import 'package:ovision/views/fotoo.dart';

class Home extends StatefulWidget {
  const Home({key, title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  
  bool _showPassword = false;

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
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              Text('O-vision',
              style: TextStyle(
                color: Colors.green,
                fontSize: 35,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(
                height: 55,
              ),
              Container(
                height: 200,
                child: Image.asset('images/as.png'),
              ),
              SizedBox(
                height: 55,
              ),
              TextField(
                controller: _emailController,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    prefixIcon: Icon(Icons.person_rounded),
                    hintText: "Digite E-mail"),

              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _senhaController,
                obscureText: _showPassword == false ? true : false,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    prefixIcon: Icon(Icons.key),
                    hintText: 'Digite Senha',
                    suffixIcon: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                      child: Icon( _showPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.grey,),
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
              ),
              
                ),
              
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   ElevatedButton(
                child: Text('ENTRAR'),
                onPressed: () {
                  login();
                  
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(130, 40)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                ),
              ),
                  ElevatedButton(
                child: Text('CADASTRAR'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cadastro(title: 'Cadastro')));
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(130, 40)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                ),
              ),
                ],
              )
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
                          builder: (context) => Fotos()));
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





