import 'package:crypto/dbhelper/database_helper.dart';
import 'package:crypto/model/criptoprice.dart';
import 'package:crypto/screen/info_crypto_screen.dart';
import 'package:flutter/material.dart'; // Importa el paquete Flutter para widgets de Material Design
import 'package:dio/dio.dart'; // Importa el paquete para realizar solicitudes HTTP
import 'dart:async';

class CriptoScreen extends StatefulWidget {
  const CriptoScreen({super.key});

  @override
  _CriptoScreenState createState() =>
      _CriptoScreenState(); // Crea el estado de la pantalla principal
}

class _CriptoScreenState extends State<CriptoScreen> {
  Dio dio = Dio(); // Instancia de la clase Dio para realizar solicitudes HTTP
  List<CryptoPrice> cryptoPrices =
      []; // Lista para almacenar la información de las criptomonedas
  int refreshIntervalInSeconds = 60; // Intervalo de actualización en segundos
  final DatabaseHelper dbHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    fetchData(); // Llama a fetchData al inicio
    dbHelper.initDatabase();

    // Establece un Timer para actualizar los datos periódicamente
    Timer.periodic(Duration(seconds: refreshIntervalInSeconds), (Timer t) {
      fetchData(); // Llama a fetchData en intervalos regulares definidos por refreshIntervalInSeconds
    });
  }

  void fetchData() async {
    try {
      Response response = await dio.get(
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,ripple,litecoin&vs_currencies=usd');
      Map<String, dynamic> cryptoData = response.data;
      setState(() {
        cryptoPrices = [
          // Crea objetos CryptoPrice con información obtenida y los agrega a la lista cryptoPrices
          CryptoPrice(
              name: 'Bitcoin',
              imagePath: 'assets/images/bitcoin.png',
              price: cryptoData['bitcoin']['usd'].toString()),
          CryptoPrice(
              name: 'Ethereum',
              imagePath: 'assets/images/ethereum.png',
              price: cryptoData['ethereum']['usd'].toString()),
          CryptoPrice(
              name: 'Ripple',
              imagePath: 'assets/images/ripple.png',
              price: cryptoData['ripple']['usd'].toString()),
          CryptoPrice(
              name: 'Litecoin',
              imagePath: 'assets/images/litecoin.png',
              price: cryptoData['litecoin']['usd'].toString()),
        ];
      });
    } catch (error) {
      setState(() {
        // En caso de error al cargar los datos, muestra un objeto CryptoPrice con información de error
        cryptoPrices = [
          CryptoPrice(
              name: 'Error',
              imagePath: 'assets/images/error.png',
              price: 'Error al cargar datos')
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Precios de Criptomonedas'),
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cryptoPrices.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.asset(
                    cryptoPrices[index].imagePath!,
                    width: 40,
                    height: 40,
                  ),
                  title: Text('${cryptoPrices[index].name}'),
                  trailing: Text('\$${cryptoPrices[index].price}'),
                ),
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () async {
                // Itera sobre cada elemento en la lista cryptoPrices
                for (CryptoPrice crypto in cryptoPrices) {
                  // Inserta el CryptoPrice actual en la base de datos
                  int result = await dbHelper.insertCryptoPrice(crypto);

                  // Verifica si la inserción fue exitosa (result > 0 indica éxito)
                  if (result > 0) {
                    // La inserción fue exitosa
                    print(
                        'CryptoPrice ${crypto.name} guardado en la base de datos.');
                  } else {
                    // Ocurrió un error durante la inserción
                    print(
                        'Error al guardar CryptoPrice ${crypto.name} en la base de datos.');
                  }
                }

                // Muestra un mensaje o realiza cualquier acción adicional después de guardar los datos
                // Por ejemplo, puedes mostrar un diálogo de éxito o navegar a otra pantalla
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Guardado exitoso'),
                      content: Text(
                          'Los datos se han guardado en la base de datos.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Cerrar el diálogo
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );

               
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
                child: const Center(
                  child:  Text(
                    'Guardar datos en BD',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
           const   SizedBox(
                height: 10,
              ),
            Padding(
             padding: EdgeInsets.only(right: 10,left: 10),
              child: GestureDetector(
                 onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoCryptoScreen(
                     
                      dbHelper: dbHelper,
                    ),
                  ),
                );
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
                      'Ver Datos Guardados',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
