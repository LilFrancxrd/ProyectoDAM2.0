class Videogame {
  final int id;
  final int genreID;
  final String nombre;
  final String descripcion;
  final double precio;
  final List<String> images;
  final String genre; // ← NUEVA propiedad para el género

  Videogame({
    required this.id,
    required this.genreID,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.images,
    required this.genre, // ← Agregar al constructor
  });

  factory Videogame.fromJson(Map<String, dynamic> json) {
    print('=== DEBUG VIDEOCAME FROMJSON ===');
    print('JSON keys: ${json.keys}');
    
    // Si el JSON viene con objeto videogame anidado (desde library)
    if (json['videogame'] != null) {
      print('📦 Extrayendo de objeto videogame anidado');
      final videogameJson = json['videogame'];
      print('🎮 Videogame keys: ${videogameJson.keys}');
      print('🎮 Title: ${videogameJson['title']}');
      print('🎮 Name: ${videogameJson['name']}');
      print('🎮 Description: ${videogameJson['description']}');
      print('🎮 Genre: ${videogameJson['genre']}');
      
      // Procesar imágenes
      List<String> images = [];
      if (videogameJson['images'] != null) {
        print('🖼️ Images found: ${videogameJson['images']}');
        images = List<Map<String, dynamic>>.from(videogameJson['images'])
            .map((img) => img['image_path']?.toString() ?? '')
            .where((url) => url.isNotEmpty)
            .toList();
      }
      
      // Procesar precio
      dynamic priceJson = videogameJson['price'];
      double priceParsed = 0.0;
      
      if (priceJson == null) {
        priceParsed = 0.0;
      } else if (priceJson is int) {
        priceParsed = priceJson.toDouble();
      } else if (priceJson is double) {
        priceParsed = priceJson;
      } else if (priceJson is String) {
        priceParsed = double.tryParse(priceJson) ?? 0.0;
      }
      
      // Procesar género - extraer el nombre del objeto genre
      String genreName = 'Sin género';
      if (videogameJson['genre'] != null && videogameJson['genre'] is Map) {
        genreName = videogameJson['genre']['name']?.toString() ?? 'Sin género';
      }
      String gameName = videogameJson['name']?.toString() ?? 
                     videogameJson['title']?.toString() ?? 
                     'Sin título';

      // Obtener descripción real
      String description = videogameJson['description']?.toString() ?? '';
      
      print('✅ Final game: ${videogameJson['title']} - $genreName');
      
      return Videogame(
        id: videogameJson['id'] ?? 0,
        genreID: videogameJson['genre_id'] ?? 0,
        nombre: gameName,
        descripcion: description, // ← Descripción real
        precio: priceParsed,
        images: images,
        genre: genreName, // ← Género como propiedad separada
      );
    } 
    // Si el JSON viene directo (desde otra fuente)
    else {
      print('📦 Mapeando JSON directo');
      
      List<String> images = [];
      if (json['images'] != null) {
        images = List<Map<String, dynamic>>.from(json['images'])
            .map((img) => img['url']?.toString() ?? img['image_path']?.toString() ?? '')
            .where((url) => url.isNotEmpty)
            .toList();
      }

      dynamic priceJson = json['price'];
      double priceParsed = 0.0;

      if (priceJson == null) {
        priceParsed = 0.0;
      } else if (priceJson is int) {
        priceParsed = priceJson.toDouble();
      } else if (priceJson is double) {
        priceParsed = priceJson;
      } else if (priceJson is String) {
        priceParsed = double.tryParse(priceJson) ?? 0.0;
      }
      
      // Para JSON directo, intentar obtener el género
      String genreName = 'Sin género';
      if (json['genre'] != null && json['genre'] is Map) {
        genreName = json['genre']['name']?.toString() ?? 'Sin género';
      } else if (json['genre_name'] != null) {
        genreName = json['genre_name']?.toString() ?? 'Sin género';
      }
      
      return Videogame(
        id: json['id'] ?? 0,
        genreID: json['genre_id'] ?? json['genreID'] ?? 0,
        nombre: json['title'] ?? json['name'] ?? '',
        descripcion: json['description'] ?? '',
        precio: priceParsed,
        images: images,
        genre: genreName,
      );
    }
  }
}