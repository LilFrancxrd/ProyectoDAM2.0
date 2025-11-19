<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class FirebaseAuth
{
    public function handle(Request $request, Closure $next)
    {
        $token = $request->bearerToken();
        
        if (!$token) {
            return response()->json(['error' => 'Token no proporcionado'], 401);
        }

        try {
            // ✅ VERSIÓN MEJORADA - Extrae UID real del token JWT de Firebase
            $parts = explode('.', $token);
            
            if (count($parts) !== 3) {
                return response()->json(['error' => 'Token JWT inválido'], 401);
            }
            
            // Decodificar el payload (segunda parte del JWT)
            $payload = json_decode(base64_decode($parts[1]), true);
            
            if (!$payload) {
                return response()->json(['error' => 'No se pudo decodificar el token'], 401);
            }
            
            // Extraer UID de Firebase (está en 'sub' o 'user_id')
            $uid = $payload['sub'] ?? $payload['user_id'] ?? null;
            
            if (!$uid) {
                return response()->json(['error' => 'UID no encontrado en el token'], 401);
            }
            
            $request->attributes->set('firebase_uid', $uid);
            
        } catch (\Exception $e) {
            return response()->json(['error' => 'Error procesando token: ' . $e->getMessage()], 401);
        }

        return $next($request);
    }
}