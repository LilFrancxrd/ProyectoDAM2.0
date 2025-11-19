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
    public function videoGames(){
        return $this->belongsTo(Videogame::class , 'unique_game_id');
    }
    public function saleItem()
    {
        return $this->belongsTo(SaleItem::class, 'unique_game_id');
    }
    
    public function user()
    {
        return $this->belongsTo(User::class, 'owner');
    }
}
