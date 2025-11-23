import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:videotrade_app/services/auth_services.dart';
import 'dart:convert';
import '../config/constants.dart';
import '../models/videogame.dart';
import '../models/owned_game.dart';
import '../services/auth_services.dart';

class LibraryProvider with ChangeNotifier {
  List<Videogame> _libraryGames = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Videogame> get libraryGames => _libraryGames;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Getter para compatibilidad con código antiguo
  List<OwnedGame> get ownedgame {   
    final ownedGames = _libraryGames.map((game) {
      final ownedGame = OwnedGame(
        id: game.id,
        name: game.nombre,
        genre: game.genre,
        hoursplayed: 0,
        imageUrl: game.images.isNotEmpty ? game.images.first : '',
      );
      
      return ownedGame;
    }).toList();
    
    return ownedGames;
  }

  /// Método seguro para notificar listeners
  void _safeNotify() {
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  /// Cargar biblioteca desde la API
  Future<void> fetchLibrary() async {
    _isLoading = true;
    _error = null;
    _safeNotify(); // ✅ Cambiado a safeNotify

    try {
      final headers = await AuthService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('${AppConstants.apiBaseUrl}/library'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> gamesData = data['data'] ?? [];   
          
          // Mapear los datos
          _libraryGames = gamesData.map((json) {
            try {
              final videogame = Videogame.fromJson(json);
              return videogame;
            } catch (e) {
              rethrow;
            }
          }).toList();

          _error = null;
          
        } else {
          _error = data['message'] ?? 'Error desconocido';
        }
      } else if (response.statusCode == 401) {
        _error = 'Sesión expirada. Inicia sesión nuevamente.';
      } else {
        _error = 'Error del servidor: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
      _safeNotify();
    }
  }

  /// Método legacy para compatibilidad (llama al real)
  Future<void> loadDummyData() async {
    await fetchLibrary();
  }

  /// Agregar juego a la biblioteca (después de comprar)
  Future<bool> addGameToLibrary(int videogameId) async {
    try {
      final headers = await AuthService.getAuthHeaders();
      final response = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/library'),
        headers: headers,
        body: jsonEncode({'videogame_id': videogameId}),
      );
      
      if (response.statusCode == 201) {
        // Recargar biblioteca
        await fetchLibrary();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Limpiar errores
  void clearError() {
    _error = null;
    _safeNotify(); // ✅ Cambiado a safeNotify
  }
}