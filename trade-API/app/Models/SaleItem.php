<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SaleItem extends Model
{
    protected $table = 'sales_items';
    
    protected $fillable = [
        'sale_id', 
        'videogame_id', 
        'nIntercambios', 
        'totalprice', 
        'status'
    ];
    
    // ✅ Relación con Videogame
    public function videoGame()
    {
        return $this->belongsTo(Videogame::class, 'videogame_id');
    }
    
    // ✅ Relación con Library
    public function library()
    {
        return $this->hasOne(Library::class, 'unique_game_id', 'id');
    }
    
    // ✅ Relación con Sale (si existe modelo Sale)
    public function sale()
    {
        return $this->belongsTo(Sale::class, 'sale_id');
    }
}