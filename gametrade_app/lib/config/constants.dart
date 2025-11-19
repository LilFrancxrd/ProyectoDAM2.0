// lib/config/constants.dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class AppConstants {
  static const String _yourLocalComputerIp = "192.168.1.103"; 
  static const String _androidEmulatorIp = "10.0.2.2";
  static const String _backendPort = "8000"; // 👈 Correcto para artisan serve
  
  static String get apiBaseUrl {
    if (kDebugMode) { 
      if (Platform.isAndroid) {
        // Para emulador con php artisan serve:
        return "http://$_androidEmulatorIp:$_backendPort/api"; // 👈 Sin /gametrade/public
      }
      return "http://localhost:$_backendPort/api";
    }
    return "https://api.yourvideotradeapp.com/api"; 
  }
}