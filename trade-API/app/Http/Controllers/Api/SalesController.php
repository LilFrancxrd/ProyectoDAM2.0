<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Sale;
use App\Models\SaleItem;
use App\Models\Library;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class SalesController extends Controller
{
    /**
     * Procesar compra del carrito
     * POST /api/sales/checkout
     */
    public function checkout(Request $request)
    {
        try {
            
            $user = $request->user();
            
            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Usuario no autenticado'
                ], 401);
            }
            
            $validated = $request->validate([
                'items' => 'required|array|min:1',
                'items.*.videogame_id' => 'required|integer|exists:videogames,id',
                'items.*.price' => 'required|numeric|min:0'
            ]);
            
            $totalPrice = collect($validated['items'])->sum('price');
            
            DB::beginTransaction();
            
            try {
                // 1. Crear venta
                $sale = Sale::create([
                    'buyer' => $user->id,
                    'totalprice' => $totalPrice,
                    
                ]);
                
                // 2. Crear items de venta y agregar a biblioteca
                foreach ($validated['items'] as $item) {
                    // Crear item de venta (copia única del juego)
                    $saleItem = SaleItem::create([
                        'sale_id' => $sale->id,
                        'videogame_id' => $item['videogame_id'],
                        'nIntercambios' => 0,  // Empieza en 0
                        'totalprice' => $item['price'],
                        'status' => 'active'
                    ]);
                    
                    // Agregar a biblioteca (referencia a la copia única)
                    Library::create([
                        'unique_game_id' => $saleItem->id,  // ID del sale_item
                        'owner' => $user->id,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]);
                }
                
                DB::commit();
                
                return response()->json([
                    'success' => true,
                    'data' => [
                        'sale_id' => $sale->id,
                        'totalprice' => $totalPrice,
                        'items_count' => count($validated['items'])
                    ],
                    'message' => 'Compra realizada exitosamente'
                ], 201);
                
            } catch (\Exception $e) {
                DB::rollBack();
                throw $e;
            }
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al procesar compra: ' . $e->getMessage()
            ], 500);
        }
    }
}