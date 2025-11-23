import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:videotrade_app/models/videogame.dart';
import 'package:videotrade_app/config/constants.dart';

class VideojuegosProvider {
  
  var uri = Uri.parse('${AppConstants.apiBaseUrl}/videogames');
  Future<List<Videogame>> fetchVideogames() async {

    
    final response = await http.get(uri);

    
    if (response.statusCode == 200) {
      try {

        final dynamic decodedData = json.decode(response.body);
  
        
        List<dynamic> datos;
        
        if (decodedData is List) {
   
          datos = decodedData;
        } else if (decodedData is Map && decodedData['data'] is List) {

          datos = decodedData['data'];
        } else {
  
          throw Exception('Formato de respuesta desconocido');
        }   
          
        if (datos.isNotEmpty) {
        }
        
        return datos.map((json) => Videogame.fromJson(json)).toList();
        
      } catch (e) {
     
        rethrow;
      }
    } else {
      throw Exception('Error HTTP: ${response.statusCode}');
    }
  }
}