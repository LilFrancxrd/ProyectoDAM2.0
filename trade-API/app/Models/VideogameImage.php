<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VideogameImage extends Model
{
    //relationship
    public function videogame(){
        return $this->belongsTo(Videogame::class);
    }
}
