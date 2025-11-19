<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Genre;

class GenreController extends Controller
{

    public function index()
    {
        return response()->json(Genre::all());
    }


    public function store(Request $request)
    {
        $genre = Genre::create([
            'nombre' => $request->nombre
        ]);

        return response()->json($genre, 201);
    }


    public function show(string $id)
    {
        $genre = Genre::find($id);
        if(!$genre){
            return response()->json(['message' => 'Genero no encontrado'],404);
        }

        return response()->json($genre);
    }


    public function update(Request $request, string $id)
    {
        $genre = Genre::find($id);
        if(!$genre){
            return response()->json(['message' => 'Genero no encontrado']);
        }
        $genre->update(['nombre' => $request->nombre]);
        
    }


    public function destroy(string $id)
    {
        $genre = Genre::find($id);
        if(!$genre){
            return response()->json(['message'=>'Genero no encontrado']);
        }
        $genre->delete();
        return response()-> json(['message' => 'Genero eliminado']);
    }
}
