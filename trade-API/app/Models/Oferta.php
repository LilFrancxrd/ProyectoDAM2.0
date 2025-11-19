<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Oferta extends Model
{
    protected $table = 'offers';
    public function videoGames(){
        return $this->belongsTo(VideoGame::class,'videogameId');
    }
}