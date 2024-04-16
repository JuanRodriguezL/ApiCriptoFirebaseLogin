import 'package:crypto/screen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
 void initState() {
    super.initState();
    // Espera 3 segundos y luego navega a la pantalla de inicio de sesión
    Future.delayed(const Duration(seconds: 3), () {
      // Utiliza pushReplacement para reemplazar la pantalla de inicio con la pantalla de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('inicializacion'),
      ),
    );
  }
}
