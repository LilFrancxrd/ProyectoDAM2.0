<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SaleItem extends Model
{
    protected $fillable = [
        'sale_id', 
        'videogame_id', 
        'nIntercambios', 
        'total_price', 
        'status'
    ];
    
    public function videoGame()
    {
        return $this->belongsTo(Videogame::class, 'videogame_id');
    }
    
    public function library()
    {
        return $this->hasOne(Library::class, 'unique_game_id');
    }
}