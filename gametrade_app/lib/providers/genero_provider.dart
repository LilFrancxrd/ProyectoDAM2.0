import 'package:http/http.dart' as http;
import 'package:videotrade_app/config/constants.dart';

import 'package:videotrade_app/models/genero.dart'; 


class GenerosProvider {

  Future<List<Genero>>getGeneros() async{
    var uri = Uri.parse('${AppConstants.apiBaseUrl}/genres');

    var respuesta = await http.get(uri);

    if(respuesta.statusCode==200){
      return genreFromJson(respuesta.body);
    }else{
      throw Exception('Falló al cargar los géneros (Código: ${respuesta.statusCode})');
    }
  }
}