import 'package:crypto/auth/firebase_auth.dart';
import 'package:crypto/model/criptoprice.dart';
import 'package:crypto/widget/form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final TextEditingController _correoConroller = TextEditingController();

  final TextEditingController _passConroller = TextEditingController();

FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CRYPTOAPP',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
           const   SizedBox(
                height: 30,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10,left: 10),
                  child: FormWidget(
                    hintTextField: 'Email',
                    controller: _correoConroller,
                  )),
           const   SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10,left: 10),
                child: FormWidget(
                  hintTextField: 'Password',
                  controller: _passConroller,
                ),
              ),
              const   SizedBox(
                height: 10,
              ),
            Padding(
             padding: EdgeInsets.only(right: 10,left: 10),
              child: GestureDetector(
                 onTap: () {
                  _signIn();
                  },
                child: Container(   
                  width: double.infinity,   
                  height: 50,     
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta? ',
                style: TextStyle(color: Colors.white)),
                TextButton(
              onPressed: () {
               Navigator.pushNamed(context, '/register'); 
              },
              child: const Text(
                ' Regístrate',
                style: TextStyle(color: Colors.white),
              ),
            )
            ],
          )
            ],
          ),
        ));

        
  }
  void _signIn() async {
   
    String correo = _correoConroller.text;
    String pass = _passConroller.text;

    User? user = await _auth.signInWithEmail(correo, pass);
    
    if (user!=null){
 Navigator.pushNamed(context, '/home');
    }else{
      print('algo salio mal');
    }
  }
}
