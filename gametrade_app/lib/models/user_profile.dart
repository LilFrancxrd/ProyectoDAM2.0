class UserProfile {
  final int id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime membersince;
  final int totalGames;
  final int totalHours;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.membersince,
    required this.totalGames,
    required this.totalHours,
  });

  //CONVIERTE JSON DEL API A OBJETO DART
  factory UserProfile.fromJson(Map<String, dynamic> json){
    return UserProfile(
      id: json['id'], 
      name: json['name'] , 
      email: json['email'], 
      avatarUrl: json['avatar_url'], 
      membersince: DateTime.parse(json['created_at']), 
      totalGames: json['total_games'] ?? 0, 
      totalHours: json['total_hours'] ?? 0
    );
  }
}