<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Library;
use App\Models\SaleItem;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Log; // ← Agregar esto

class LibraryController extends Controller
{   
    /**
     * Obtener biblioteca del usuario autenticado
     */
    public function index(Request $request)
    {
        try {
            $user = $request->user();
            
            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Usuario no autenticado'
                ], 401);
            }

            Log::info('=== DEBUG BIBLIOTECA DETALLADO ===');
            Log::info('Usuario ID: ' . $user->id);
            
            // Cargar library con relaciones
            $library = Library::with([
                'saleItem.videoGame.images',
                'saleItem.videoGame.genre'
            ])->where('owner', $user->id)->get();

            Log::info('Library con relaciones: ' . $library->count());
            
            // DEBUG DETALLADO DE RELACIONES
            foreach($library as $item) {
                Log::info("--- Library ID: {$item->id} ---");
                Log::info("Unique Game ID: {$item->unique_game_id}");
                Log::info("SaleItem: " . ($item->saleItem ? 'EXISTE' : 'NULL'));
                
                if($item->saleItem) {
                    Log::info("SaleItem ID: {$item->saleItem->id}");
                    Log::info("VideoGame: " . ($item->saleItem->videoGame ? 'EXISTE' : 'NULL'));
                    
                    if($item->saleItem->videoGame) {
                        $vg = $item->saleItem->videoGame;
                        Log::info("VideoGame Title: " . $vg->title);
                        Log::info("VideoGame Genre: " . ($vg->genre ? $vg->genre->name : 'NULL'));
                        Log::info("VideoGame Images count: " . ($vg->images ? $vg->images->count() : '0'));
                        
                        // Debug de IDs importantes
                        Log::info("VideoGame ID: " . $vg->id);
                        Log::info("Genre ID: " . $vg->genre_id);
                    } else {
                        Log::warning("VideoGame NO encontrado para saleItem ID: {$item->saleItem->id}");
                        Log::info("Videogame ID en sale_item: " . $item->saleItem->videogame_id);
                    }
                }
                Log::info("----------------------------");
            }
            
            // Formatear respuesta con manejo de errores
            $games = $library->map(function($item) {
                if (!$item->saleItem) {
                    Log::warning('SaleItem no encontrado para library ID: ' . $item->id);
                    return null;
                }

                $saleItem = $item->saleItem;
                $videoGame = $saleItem->videoGame;
                
                // Si no hay videoGame, crear un objeto básico para evitar errores
                if (!$videoGame) {
                    Log::warning('VideoGame no encontrado para saleItem ID: ' . $saleItem->id);
                    $videoGame = (object)[
                        'id' => $saleItem->videogame_id,
                        'title' => 'Juego no disponible',
                        'description' => 'Información no disponible',
                        'genre' => null,
                        'images' => collect(),
                        'genre_id' => null
                    ];
                }
                
                return [
                    'library_id' => $item->id,
                    'unique_game_id' => $item->unique_game_id,
                    'videogame' => $videoGame,
                    'nIntercambios' => $saleItem->nIntercambios,
                    'maxIntercambios' => 5,
                    'canTrade' => $saleItem->nIntercambios < 5,
                    'status' => $saleItem->status
                ];
            })->filter();
            
            Log::info('Juegos formateados: ' . $games->count());
            Log::info('=== FIN DEBUG BIBLIOTECA ===');
            
            return response()->json([
                'success' => true,
                'data' => $games->values(),
                'message' => 'Biblioteca cargada correctamente'
            ]);
            
        } catch (\Exception $e) {
            Log::error('Error en biblioteca: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());
            return response()->json([
                'success' => false,
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }
}