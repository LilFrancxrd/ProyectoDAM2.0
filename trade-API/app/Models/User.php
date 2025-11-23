<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    protected $fillable = [
        'firebase_uid',
        'email',
        'name', 
        'password',
        'role'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    // Relaciones
    public function tradesFrom()
    {
        return $this->hasMany(Trade::class, 'from_user');
    }

    public function tradesTo()
    {
        return $this->hasMany(Trade::class, 'to_user');
    }

    public function saleItems()
    {
        return $this->hasMany(SaleItem::class);
    }

    public function library()
    {
        return $this->hasMany(Library::class);
    }

    public function offers()
    {
        return $this->hasMany(Offer::class);
    }
}