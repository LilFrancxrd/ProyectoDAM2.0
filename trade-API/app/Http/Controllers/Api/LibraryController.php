<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Library;
use App\Models\SaleItem;
use App\Http\Controllers\Controller;

class LibraryController extends Controller
{   
    /**
     * Obtener biblioteca del usuario autenticado
     */
    public function index(Request $request)
    {
        try {
            $firebaseUid = $request->attributes->get('firebase_uid');
            $user = User::where('firevase_uid', $firebaseUid)->first();
            
            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Usuario no autenticado'
                ], 401);
            }
            
            // Obtener biblioteca con información completa
            $library = Library::with([
                'saleItem.videoGame.images',
                'saleItem.videoGame.genre'
            ])
            ->where('owner', $user->id)
            ->get();
            
            // Formatear respuesta
            $games = $library->map(function($item) {
                $saleItem = $item->saleItem;
                $videoGame = $saleItem->videoGame;
                
                return [
                    'library_id' => $item->id,
                    'unique_game_id' => $item->unique_game_id,
                    'videogame' => $videoGame,
                    'nIntercambios' => $saleItem->nIntercambios,
                    'maxIntercambios' => 5, // Límite máximo 
                    'canTrade' => $saleItem->nIntercambios < 5,
                    'status' => $saleItem->status
                ];
            });
            
            return response()->json([
                'success' => true,
                'data' => $games,
                'message' => 'Biblioteca cargada correctamente'
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }
}