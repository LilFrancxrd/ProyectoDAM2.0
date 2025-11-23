<?php
// app/Helpers/AuthHelper.php

namespace App\Helpers;

use App\Models\User;

class AuthHelper
{
    /**
     * Obtener usuario desde Firebase UID
     * Si no existe, lo crea automáticamente
     */
    public static function getUserFromFirebaseUid(string $firebaseUid, ?array $firebaseData = null): ?User
    {
        // Buscar usuario existente
        $user = User::where('firebase_uid', $firebaseUid)->first();
        
        // Si no existe, crearlo
        if (!$user && $firebaseData) {
            $user = User::create([
                'firebase_uid' => $firebaseUid,
                'email' => $firebaseData['email'] ?? null,
                'name' => $firebaseData['name'] ?? 'Usuario',
            ]);
        }
        
        return $user;
    }
}