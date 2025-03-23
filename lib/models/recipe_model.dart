import 'dart:convert';
import 'dart:math';

class Recipe {
  final String nombre;
  final String author;
  final String image_link;
  final List<String> recipeSteps;

  const Recipe({
    required this.nombre,
    required this.author,
    required this.image_link,
    required this.recipeSteps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      nombre: json['nombre'],
      author: json['autor'],
      image_link: json['imagen_url'],
      recipeSteps: List<String>.from(json['instrucciones']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "autor": author,
      "imagen_url": image_link,
      "instrucciones": recipeSteps,
    };
  }

  @override
  String toString() {
    return """Recipe{Titulo: $nombre, Autor: $author, linkImagen: $image_link, Pasos: $recipeSteps} """;
  }
}
