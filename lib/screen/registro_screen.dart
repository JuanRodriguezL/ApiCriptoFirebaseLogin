import 'package:crypto/auth/firebase_auth.dart';
import 'package:crypto/model/criptoprice.dart';
import 'package:crypto/widget/form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userConroller = TextEditingController();
  final TextEditingController _correoConroller = TextEditingController();
  final TextEditingController _passConroller = TextEditingController();
  FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    _userConroller.dispose();
    _correoConroller.dispose();
    _passConroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CRYPTOAPP',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Registro',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: FormWidget(
                    hintTextField: 'Nombre',
                    controller: _userConroller,
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: FormWidget(
                  hintTextField: 'Correo Electronico',
                  controller: _correoConroller,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: FormWidget(
                  hintTextField: 'Password',
                  controller: _passConroller,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                   _signUp();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: Text(
                        'Registrarme',
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
                  const Text('¿Ya tienes una cuenta? ',
                      style: TextStyle(color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text(
                      ' Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _signUp() async {
    String username = _userConroller.text;
    String correo = _correoConroller.text;
    String pass = _passConroller.text;

    User? user = await _auth.signUpWithEmail(correo, pass);
    
    if (user!=null){
 Navigator.pushNamed(context, '/login');
    }else{
      print('algo salio mal');
    }
  }
}
