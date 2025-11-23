<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sale extends Model
{
    protected $fillable = [
        'buyer',
        'totalprice'
    ];

    // Relación con el usuario comprador
    public function user()
    {
        return $this->belongsTo(User::class, 'buyer');
    }

    // Relación con los items de la venta
    public function saleItems()
    {
        return $this->hasMany(SaleItem::class, 'sale_id');
    }

    // Relación con la biblioteca a través de saleItems
    public function libraryItems()
    {
        return $this->hasManyThrough(
            Library::class, 
            SaleItem::class, 
            'sale_id',      // Foreign key en sale_items
            'unique_game_id', // Foreign key en library  
            'id',           // Local key en sales
            'id'            // Local key en sale_items
        );
    }
}