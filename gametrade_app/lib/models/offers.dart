class Oferta{
  final int idOferta;
  final int videogameId;
  final String nombreJuego;
  final double discount;
  final DateTime startDate;
  final DateTime endDate;

  final double?precioOriginal;
  final String?imagenUrl;

  Oferta({
    required this.idOferta,
    required this.videogameId,
    required this.nombreJuego,
    required this.discount,
    required this.startDate,
    required this.endDate,
    this.precioOriginal,
    this.imagenUrl
  });

  factory Oferta.fromJson(Map<String, dynamic>json){
    dynamic discountJson = json['discount'];
    double discountParsed;

    if(discountJson == null){
      discountParsed = 0.0;
    }else if(discountJson is double){
      discountParsed = discountJson;
    }else if(discountJson is int){
      discountParsed = discountJson.toDouble();
    }else if(discountJson is String){
      discountParsed = double.tryParse(discountJson) ?? 0.0;
    }else{
      discountParsed = 0.0;
    }


    DateTime startDateParsed;
    DateTime endDateParsed;

    try{
      startDateParsed = DateTime.parse(json['start_date']);
    }catch(e){
      startDateParsed = DateTime.now();
    }

    try {
      endDateParsed = DateTime.parse(json['end_date']);
    } catch (e) {
      endDateParsed = DateTime.now().add(Duration(days: 30));
    }


    // double?precioOriginal;
    String?imagenUrl;
    
    if(json['video_games']!=null){
      final videoGame = json['video_games'];
      // precioOriginal = _parseDouble(videoGame['price']);

      if(videoGame['images'] != null && videoGame['images']is List){
        final images = videoGame['images'] as List;
        if(images.isNotEmpty && images[0]['image_path']!= null){
          imagenUrl = images[0]['image_path'] as String;
          print('🖼️ [OFERTA] Imagen obtenida: $imagenUrl');
        }
      }
    }

    return Oferta(
      idOferta: json['idOferta'] ?? 0,
      videogameId: json['videogameId'] ?? 0, 
      nombreJuego: json['nombreJuego'] ?? '', 
      discount: discountParsed, 
      startDate: startDateParsed, 
      endDate: endDateParsed,
      imagenUrl: imagenUrl
    );
  }
}