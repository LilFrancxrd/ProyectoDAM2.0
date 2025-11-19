<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Trade extends Model
{
    protected $fillable = [
        'sale_item_id',
        'from_user',
        'to_user',
        'trade_date'
    ];
    
    public function saleItem()
    {
        return $this->belongsTo(SaleItem::class);
    }
    
    public function fromUser()
    {
        return $this->belongsTo(User::class, 'from_user');
    }
    
    public function toUser()
    {
        return $this->belongsTo(User::class, 'to_user');
    }
}