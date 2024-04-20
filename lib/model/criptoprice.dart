class CryptoPrice {

  int? id; // ID de la criptomoneda en la base de datos SQLite
  String? name; // Nombre de la criptomoneda
  String? imagePath; // Ruta de la imagen de la criptomoneda
  String? price; // Precio de la criptomoneda en USD/ Precio de la criptomoneda

  CryptoPrice({this.id, this.name, this.imagePath, this.price});

   factory CryptoPrice.fromMap(Map<String, dynamic> json) {
    return CryptoPrice(
      id: json["id"], // Asigna el id desde el mapa.
      name: json["nombre"], // Asigna el nombre desde el mapa.
      price: json["imagePath"], // Asigna los apellidos desde el mapa.
      imagePath: json["price"], // Asigna la cédula desde el mapa.
    );
  }

  // Método para convertir una Persona a un Map.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id, // Si el id no es nulo, añade el id al mapa.
      "nombre": name, // Añade el nombre al mapa.
      "imagePath": imagePath, // Añade la cédula al mapa.
      "price": price, 
    };
  }
}

