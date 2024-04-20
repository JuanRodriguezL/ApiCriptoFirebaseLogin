

import 'package:crypto/screen/cripto_screen.dart';
import 'package:crypto/screen/login_screen.dart';
import 'package:crypto/screen/registro_screen.dart';
import 'package:crypto/screen/splash_screen.dart';
import 'package:crypto/screen/info_crypto_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; // Importa el paquete Flutter para widgets de Material Design
 // Importa el paquete para utilizar objetos relacionados con el tiempo (Timer)

Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Tema oscuro para la aplicación
      debugShowCheckedModeBanner: false, // Oculta el banner de depuración
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const LoginScreen(),  
        '/home': (context) => const CriptoScreen(),
         '/register': (context) => const RegisterScreen(),
          
        
      },
    );
  }
}


