<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Library extends Model
{
    protected $table = 'library';

    protected $fillable = [
        'unique_game_id',
        'owner'
    ];

    // ✅ Relación CORRECTA con SaleItem
    public function saleItem()
    {
        return $this->belongsTo(SaleItem::class, 'unique_game_id', 'id');
    }

    // ✅ Relación con User
    public function user()
    {
        return $this->belongsTo(User::class, 'owner');
    }

    // ✅ Relación con Videogame a través de SaleItem
    public function videoGame()
    {
        return $this->hasOneThrough(
            Videogame::class,
            SaleItem::class,
            'id', // Foreign key on SaleItem table
            'id', // Foreign key on Videogame table
            'unique_game_id', // Local key on Library table (sale_item_id)
            'videogame_id' // Local key on SaleItem table
        );
    }
}