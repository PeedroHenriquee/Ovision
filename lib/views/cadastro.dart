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
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(padding: EdgeInsets.all(32.0),
        child: Column(
          children :[
            Text('Cadastro',
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 150,
              child: Image.asset('images/as.png'),
            ),
            //Separarção entre a foto e o espaço de loguin.
            SizedBox(
              height: 55,
            ),
            //classe para incluir o email
            TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    label: Text('Digite seu nome'),
                    prefixIcon:
                    Icon(Icons.account_box_outlined))),
            SizedBox(
              height: 10),
            TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    label: Text('Digite seu e-mail'),
                    prefixIcon: Icon(Icons.email))),
              SizedBox(
              height: 10),
            TextFormField(
                controller: _psController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    label: Text('Digite sua senha'), 
                    prefixIcon: Icon(Icons.key_off))),
            SizedBox(
              height: 60,
            ),

             Container(
                height:60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end:Alignment.bottomRight,
                    stops:[0.3,1],
                    colors:[
                      Color(0xFF06881D),
                      Color.fromARGB(255, 12, 172, 57),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )
                ),
                child:SizedBox.expand(
                  child: TextButton(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(                          
                          "   Cadastrar",
                          style:TextStyle(
                            fontWeight: FontWeight.w600,
                            color:Colors.white,
                            fontSize:18,
                          ),
                          textAlign: TextAlign.left,
                          ),
                      ],
                    ),
                    onPressed: () => {
                      cadastrar()
                    },
                  ),
                ),
              ),

              SizedBox(height: 15),

              Container(
                height:40,
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    "Já tem uma conta? Faça Login!",
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(title:
                          'Home')));
                  }
                ),
              ),
            //botao para cadastrar usúario.
            ]
          ),
        ),
      )
    );
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
