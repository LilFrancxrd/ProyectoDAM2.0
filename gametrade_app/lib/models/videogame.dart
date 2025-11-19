class Videogame{
  final int id;
  final int genreID;
  final String nombre;
  final String descripcion;
  final double precio;
  final List<String> images;

  Videogame({
    required this.id,
    required this.genreID,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.images,
  });


factory Videogame.fromJson(Map<String, dynamic> json){
  List<String> images = [];
  if (json['images'] != null){
    images = List<Map<String, dynamic>>.from(json['images']).map((img)=> img['image_path'] as String).toList();
  }

    dynamic priceJson = json['price'];
    int priceParsed;

    if (priceJson == null) {
      priceParsed = 0; 
    } else if (priceJson is int) {
      priceParsed = priceJson;
    } else if (priceJson is double) {
      priceParsed = priceJson.toInt();
    } else if (priceJson is String) {
      priceParsed = int.tryParse(priceJson) ?? 0;
    } else {
      priceParsed = 0;
    }
  return Videogame(
    id: json['id']?? 0 ,
    genreID: json['genreID'] ?? 0,
    nombre: json['name'] ?? '',
    descripcion: json['description']?? '',
    precio: priceParsed.toDouble(), 
    images: images,
    );
  }
}