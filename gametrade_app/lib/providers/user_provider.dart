import 'package:flutter/material.dart';
import 'package:videotrade_app/models/user_profile.dart';

class UserProvider with ChangeNotifier{
  UserProfile? _currentUser;

  UserProfile? get currentUser => _currentUser;

  Future<void>loadDummyData() async{
    await Future.delayed(Duration(milliseconds: 500));
    _currentUser = UserProfile(
      id: 1, 
      name: "Matias Fernandez", 
      email: "mati@gmail.com", 
      avatarUrl: "", 
      membersince: DateTime(2024,11,1), 
      totalGames: 5, 
      totalHours: 45
    );
    notifyListeners();
  }
}