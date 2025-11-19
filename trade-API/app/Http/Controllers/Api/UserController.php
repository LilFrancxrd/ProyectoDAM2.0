<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
     * Sincronizar usuario de Firebase con la base de datos
     * POST /api/users/sync-firebase
     */
    public function syncFirebaseUser(Request $request)
    {
        try {
            $request->validate([
                'firebase_uid' => 'required|string',
                'email' => 'required|email',
                'name' => 'required|string',
            ]);

            // Buscar usuario por Firebase UID o email
            $user = User::where('firebase_uid', $request->firebase_uid)
                       ->orWhere('email', $request->email)
                       ->first();

            if (!$user) {
                // Crear nuevo usuario
                $user = User::create([
                    'firebase_uid' => $request->firebase_uid,
                    'email' => $request->email,
                    'name' => $request->name,
                    'role' => 'user', // rol por defecto
                    'password' => Hash::make(uniqid()), // contraseña dummy
                ]);
            } else {
                // Actualizar Firebase UID si es necesario
                if ($user->firebase_uid !== $request->firebase_uid) {
                    $user->update(['firebase_uid' => $request->firebase_uid]);
                }
            }

            return response()->json([
                'success' => true,
                'data' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'firebase_uid' => $user->firebase_uid
                ],
                'message' => 'Usuario sincronizado correctamente'
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al sincronizar usuario: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtener usuario actual
     * GET /api/users/me
     */
    public function getCurrentUser(Request $request)
    {
        try {
            $firebaseUid = $request->attributes->get('firebase_uid');
            $user = User::where('firebase_uid', $firebaseUid)->first();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Usuario no encontrado'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $user
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener usuario: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Actualizar usuario actual
     * PUT /api/users/me
     */
    public function updateCurrentUser(Request $request)
    {
        try {
            $firebaseUid = $request->attributes->get('firebase_uid');
            $user = User::where('firebase_uid', $firebaseUid)->first();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Usuario no encontrado'
                ], 404);
            }

            $validated = $request->validate([
                'name' => 'sometimes|string|max:255',
                'email' => 'sometimes|email|unique:users,email,' . $user->id,
            ]);

            $user->update($validated);

            return response()->json([
                'success' => true,
                'data' => $user,
                'message' => 'Usuario actualizado correctamente'
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar usuario: ' . $e->getMessage()
            ], 500);
        }
    }


}