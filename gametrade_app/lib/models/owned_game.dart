class OwnedGame {
  final int id;
  final String name;
  final String genre;
  final int hoursplayed;
  final String? imageUrl;

  OwnedGame({
    required this.id,
    required this.name,
    required this.genre,
    required this.hoursplayed,
    required this.imageUrl,
  });

  factory OwnedGame.fromJson(Map<String, dynamic> json){
    return OwnedGame(
      id: json['id'], 
      name: json['name'], 
      genre: json['genre'] ?? 'Sin genero', 
      hoursplayed: json['hours_played'] ?? 0, 
      imageUrl: json['image_url']
    );
  }
}