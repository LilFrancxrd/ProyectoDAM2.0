import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/constants.dart';

class AuthService {
  /// Obtener token de Firebase del usuario actual
  static Future<String?> getToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        return token;
      }
      return null;
    } catch (e) {
      print('❌ Error obteniendo token: $e');
      return null;
    }
  }
  
  /// Obtener headers con autenticación para requests
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    
    if (token == null) {
      throw Exception('No hay usuario autenticado');
    }
    
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
  
  /// 🧪 Probar conexión con la API (para debug)
  static Future<void> testApiConnection() async {
    try {
      print('🔄 Probando conexión con API...');
      
      final token = await getToken();
      if (token == null) {
        print('❌ No hay token disponible');
        return;
      }
      
      print('🔑 Token obtenido (primeros 50 chars): ${token.substring(0, 50)}...');
      
      final response = await http.get(
        Uri.parse('${AppConstants.apiBaseUrl}/test-firebase-auth'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      
      print('📡 Status Code: ${response.statusCode}');
      print('📡 Response: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Conexión exitosa!');
        print('   Firebase UID: ${data['firebase_uid']}');
        print('   Message: ${data['message']}');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
      
    } catch (e) {
      print('❌ Error en testApiConnection: $e');
    }
  }
}