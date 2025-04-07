import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_book/models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];
  List<Recipe> favoriteRecipe = [];

  Future<void> FetchRecipes() async {
    isLoading = true;
    notifyListeners();
    // Los puertos para android e ios son distintos
    // Android 10.0.2.2
    // iOS 127.0.0.1
    final url = Uri.parse(
      "https://c5332eb5-1486-4627-acf2-d6c0f27e6fa4.mock.pstmn.io/recipe",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes = List<Recipe>.from(
          data['recetas'].map((recipe) => Recipe.fromJson(recipe)),
        );
      } else {
        debugPrint('Error ${response.statusCode}');
        recipes = [];
      }
    } on Exception catch (e) {
      debugPrint("Error in the request");
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Recipe recipe) async {
    final bool isFavourite = favoriteRecipe.contains(recipe);
    try {
      final url = Uri.parse(
        "https://c5332eb5-1486-4627-acf2-d6c0f27e6fa4.mock.pstmn.io/favorites",
      );

      final response =
          isFavourite
              ? await http.delete(url, body: json.encode({"id": recipe.id}))
              : await http.post(url, body: json.encode(recipe.toJson()));
      if (response.statusCode == 200) {
        if (isFavourite) {
          favoriteRecipe.remove(recipe);
        } else {
          favoriteRecipe.add(recipe);
        }
        notifyListeners();
      } else {
        throw Exception("Failed to update favourites");
      }
    } catch (e) {
      print('Error updating favorit status $e');
    }
  }
}
