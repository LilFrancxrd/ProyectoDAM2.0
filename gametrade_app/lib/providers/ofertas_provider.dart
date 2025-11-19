import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:videotrade_app/models/offers.dart';
import 'package:videotrade_app/config/constants.dart';

class OfertasProvider with ChangeNotifier {
  
  
  var uri = Uri.parse('${AppConstants.apiBaseUrl}/offers');
  
  List<Oferta> _ofertas = [];
  bool _loading = false;
  String? _error;

  List<Oferta> get ofertas => _ofertas;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> cargarOfertas() async {
    _loading = true;
    notifyListeners();

    try {

      final response = await http.get(uri);   
      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);     
        List<dynamic> datos;      
        if (decodedData is List) {
          datos = decodedData;
        } else if (decodedData is Map && decodedData['data'] is List) {
          datos = decodedData['data'];       
        } else {    
          datos = [];
        }
               
        if (datos.isNotEmpty) {
          (datos[0] as Map).forEach((key, value) {
            print('   $key: $value (${value.runtimeType})');
          });
        }
       
        _ofertas = datos.map((json) => Oferta.fromJson(json)).toList();

        _error = null;
        
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
      
    } catch (e) {
      _error = 'Error al cargar ofertas: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}