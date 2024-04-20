import 'package:crypto/dbhelper/database_helper.dart';
import 'package:crypto/model/criptoprice.dart';
import 'package:flutter/material.dart';

class InfoCryptoScreen extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const InfoCryptoScreen({
    Key? key,
    required this.dbHelper,
  }) : super(key: key);

  @override
  State<InfoCryptoScreen> createState() => _InfoCryptoScreenState();
}



class _InfoCryptoScreenState extends State<InfoCryptoScreen> {

 late Future<List<CryptoPrice>> _cryptoListFuture;

@override
void initState() {
  super.initState();
   _refreshCryptoList();
  
}
 Future<void> _refreshCryptoList() async {
    setState(() {
      _cryptoListFuture = widget.dbHelper.getCryptoPrice();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de Criptos'),
      ),
      body: FutureBuilder<List<CryptoPrice>>(
        future: _cryptoListFuture, // Llama al método para obtener la lista de criptomonedas desde la base de datos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Error al cargar datos'), // Muestra un mensaje en caso de error
            );
          }

          List<CryptoPrice>? cryptoList = snapshot.data;

          if (cryptoList == null || cryptoList.isEmpty) {
            return const Center(
              child: Text(
                  'No hay datos disponibles'), // Muestra un mensaje si no hay datos en la lista
            );
          }

          return ListView.builder(
            itemCount: cryptoList.length,
            itemBuilder: (context, index) {
              final crypto = cryptoList[index];
              return ListTile(
                title: Text('Name: ${crypto.name}'),
                subtitle: Text('Precio: ${crypto.imagePath}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    if (crypto.id != null) {
                      await widget.dbHelper.deleteCryptoPrice(crypto.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Criptomoneda eliminada'),
                        ),
                      );
                      _refreshCryptoList(); // Actualiza la lista después de eliminar
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
