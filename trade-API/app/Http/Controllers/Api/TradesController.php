<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Trade;
use App\Models\Library;
use App\Models\SaleItem;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class TradesController extends Controller
{
    /**
     * Intercambiar juego con otro usuario
     * POST /api/trades
     * 
     * Body: {
     *   "unique_game_id": 1,
     *   "to_user_id": 2
     * }
     */
    public function trade(Request $request)
    {
        try {
            $firebaseUid = $request->attributes->get('firebase_uid');
            $user = User::where('firebase_uid', $firebaseUid)->first();
            
            $validated = $request->validate([
                'unique_game_id' => 'required|integer|exists:sale_items,id',
                'to_user_id' => 'required|integer|exists:users,id'
            ]);
            
            // Verificar que el juego pertenezca al usuario
            $library = Library::where('unique_game_id', $validated['unique_game_id'])
                ->where('owner', $user->id)
                ->first();
            
            if (!$library) {
                return response()->json([
                    'success' => false,
                    'message' => 'No posees este juego'
                ], 403);
            }
            
            // Verificar límite de intercambios
            $saleItem = SaleItem::find($validated['unique_game_id']);
            
            if ($saleItem->nIntercambios >= 5) {
                return response()->json([
                    'success' => false,
                    'message' => 'Has alcanzado el límite de intercambios para este juego'
                ], 400);
            }
            
            if ($saleItem->status !== 'active') {
                return response()->json([
                    'success' => false,
                    'message' => 'Este juego no está disponible para intercambio'
                ], 400);
            }
            
            DB::beginTransaction();
            
            try {
                // 1. Registrar el intercambio
                Trade::create([
                    'sale_item_id' => $validated['unique_game_id'],
                    'from_user' => $user->id,
                    'to_user' => $validated['to_user_id'],
                    'trade_date' => now()
                ]);
                
                // 2. Incrementar contador de intercambios
                $saleItem->increment('nIntercambios');
                
                // 3. Cambiar propietario en biblioteca
                $library->update([
                    'owner' => $validated['to_user_id'],
                    'updated_at' => now()
                ]);
                
                // 4. Si alcanzó el límite, marcar como 'locked'
                if ($saleItem->nIntercambios >= 5) {
                    $saleItem->update(['status' => 'locked']);
                }
                
                DB::commit();
                
                return response()->json([
                    'success' => true,
                    'message' => 'Juego intercambiado exitosamente',
                    'data' => [
                        'nIntercambios' => $saleItem->nIntercambios,
                        'canTrade' => $saleItem->nIntercambios < 5
                    ]
                ]);
                
            } catch (\Exception $e) {
                DB::rollBack();
                throw $e;
            }
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }
    
    /**
     * Historial de intercambios del usuario
     * GET /api/trades/history
     */
    public function history(Request $request)
    {
        try {
            $user = $request->user();
            
            $trades = Trade::with(['saleItem.videoGame', 'fromUser', 'toUser'])
                ->where('from_user', $user->id)
                ->orWhere('to_user', $user->id)
                ->orderBy('trade_date', 'desc')
                ->get();
            
            return response()->json([
                'success' => true,
                'data' => $trades
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }
}