import 'package:flutter/material.dart';
import 'package:videotrade_app/models/owned_game.dart';

class LibraryProvider with ChangeNotifier{
  List<OwnedGame> _ownedGames = [];
  List<OwnedGame> get ownedgame => _ownedGames;

  Future<void> loadDummyData() async {
    await Future.delayed(Duration(milliseconds: 500));
    _ownedGames = [

      OwnedGame(
        id: 1, 
        name: 'Battlefield 6', 
        genre: 'Disparos, Accion', 
        hoursplayed: 24, 
        imageUrl: ''
      ),
      OwnedGame(
        id: 1, 
        name: 'GTA V', 
        genre: 'Mundo Abierto', 
        hoursplayed: 300, 
        imageUrl: ''
      ),
      OwnedGame(
        id: 1, 
        name: 'GTA VI', 
        genre: 'Mundo Abierto', 
        hoursplayed: 50, 
        imageUrl: ''
      ),
      OwnedGame(
        id: 1, 
        name: 'Red Dead Redemption 2', 
        genre: 'Vaqueros, Accion', 
        hoursplayed: 100, 
        imageUrl: ''
      ),
      OwnedGame(
        id: 1, 
        name: 'The Witcher 3', 
        genre: 'Mundo Abierto', 
        hoursplayed: 140, 
        imageUrl: ''
      ),
    ];
    notifyListeners();
  }
}