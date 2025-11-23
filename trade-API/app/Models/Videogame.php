<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Videogame extends Model
{
    protected $fillable = [
        'genre_id',
        'name',
        'description',
        'price'
    ];

    public function getTitleAttribute()
    {
        return $this->name;
    }
    //relationships
    public function images(){
        return $this->hasMany(VideogameImage::class);
    }
    public function genre(){
        return $this->belongsTo(Genre::class);
    }

    public function offer(){
        return $this->hasOne(Oferta::class);
    }
    public function library(){
        return $this->hasOne(Library::class, 'unique_game_id');
    }


}
