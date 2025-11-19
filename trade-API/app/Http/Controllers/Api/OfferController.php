<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Oferta;
use App\Http\Controllers\Controller;

class OfferController extends Controller
{
    public function index()
    {
        try{
            $ofertas = Oferta::with('videoGames')->get();

            return response()->json([
                'success' => true,
                'data' => $ofertas,
                'message' => 'Ofertas obtenidas correctamente'
            ]);
        }catch(\Exception $e){
            return response()->json([
                'success'=> false,
                'message' => 'Error al obtener ofertas: ' .$e->getMessage()
            ],500);
        }
    }
}