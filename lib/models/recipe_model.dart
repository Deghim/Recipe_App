import 'dart:convert';
import 'dart:math';

class Recipe {
  final int id;
  final String nombre;
  final String author;
  final String image_link;
  final List<String> recipeSteps;

  const Recipe({
    required this.id,
    required this.nombre,
    required this.author,
    required this.image_link,
    required this.recipeSteps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      nombre: json['nombre'],
      author: json['autor'],
      image_link: json['imagen_url'],
      recipeSteps:
          json['instrucciones'] is List
              ? List<String>.from(json['instrucciones'])
              : [json['instrucciones'].toString()],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "autor": author,
      "imagen_url": image_link,
      "instrucciones": recipeSteps,
    };
  }

  @override
  String toString() {
    return """Recipe{Id: $id, Titulo: $nombre, Autor: $author, linkImagen: $image_link, Pasos: $recipeSteps} """;
  }
}
