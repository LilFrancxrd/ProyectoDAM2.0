import 'dart:convert';

List<Genero> genreFromJson(String str) => 
    List<Genero>.from(json.decode(str).map((x) => Genero.fromJson(x)));
class Genero {
  final int id;
  final String nombre;

  Genero({
    required this.id,
    required this.nombre
  });

  factory Genero.fromJson(Map<String, dynamic> json) => Genero(
    id: json['id'], 
    nombre: json['name']
  );
}
