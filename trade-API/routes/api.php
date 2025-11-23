<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\VideogameController;
use App\Http\Controllers\Api\GenreController;
use App\Http\Controllers\Api\OfferController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\LibraryController;
use App\Http\Controllers\Api\SalesController;
use App\Http\Controllers\Api\TradesController;

// RUTAS PÚBLICAS 
Route::get('/videogames', [VideogameController::class, 'index']);
Route::get('/genres', [GenreController::class, 'index']);
Route::get('/offers', [OfferController::class, 'index']);

// RUTA DE PRUEBA FIREBASE (usando clase completa)
Route::get('/test-firebase-auth', function (Request $request) {
    $firebaseUid = $request->attributes->get('firebase_uid');
    return response()->json([
        'success' => true,
        'firebase_uid' => $firebaseUid,
        'message' => '✅ Firebase auth funciona correctamente!'
    ]);
})->middleware(\App\Http\Middleware\FirebaseAuth::class); // 👈 Cambiado

// RUTAS PROTEGIDAS (usando clase completa)
Route::middleware(\App\Http\Middleware\FirebaseAuth::class)->group(function () { // 👈 Cambiado
    
    // users
    Route::get('/users', [UserController::class, 'index']);
    Route::get('/users/{id}', [UserController::class, 'show']);
    Route::put('/users/{id}', [UserController::class, 'update']);
    Route::delete('/users/{id}', [UserController::class, 'destroy']);
    
    // library
    Route::get('/library', [LibraryController::class, 'index']);
    
    // sales
    Route::post('/sales/checkout', [SalesController::class, 'checkout']);
    Route::get('/sales', [SalesController::class, 'index']);
    Route::get('/sales/{id}', [SalesController::class, 'show']);
    
    // trades
    Route::post('/trades', [TradesController::class, 'trade']);
    Route::get('/trades/history', [TradesController::class, 'history']);
});

// RUTAS DE REGISTRO/LOGIN FIREBASE 
Route::post('/users/sync-firebase', [UserController::class, 'syncFirebaseUser']);
Route::post('/users', [UserController::class, 'store']);