import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ovision/views/myhomepage.dart';

class Cadastro extends StatefulWidget {
  Cadastro({Key key, String title}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _psController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      
      //incluir  logo.
      body: ListView(padding: EdgeInsets.all(32.0), children: [
        SizedBox(
          height: 50,

        ),
        SizedBox(
          height: 150,
          child: Image.asset('images/as.png'),
        ),
        //Separarção entre a foto e o espaço de loguin.
        SizedBox(
          height: 40,
        ),
        //classe para incluir o email
        TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(
                label: Text('Digite seu nome'),
                icon: Icon(Icons.account_box_outlined))),
        TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                label: Text('Digite seu e-mail'), icon: Icon(Icons.email))),
        TextFormField(
            controller: _psController,
            obscureText: true,
            decoration: InputDecoration(
                label: Text('Digite sua senha'), icon: Icon(Icons.key_off))),
        SizedBox(
          height: 60,
        ),
        //botao para cadastrar usúario.
        ElevatedButton(
          onPressed: () {
            cadastrar();
          },
          child: Text('CADASTRAR'),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(120, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))

          ),
        ),
      ]
    ));
  }

  cadastrar() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _psController.text);
      if (userCredential != null) {
        userCredential.user.updateDisplayName(_nomeController.text);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home(title: 'principal')),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Crie uma senha mas forte'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('este e-mail ja foi cadastrado, tente outro e-mail'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
