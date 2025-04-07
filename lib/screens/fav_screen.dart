import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, value, child) {
          final favoritesRecipes = value.favoriteRecipe;
          return favoritesRecipes.isEmpty
              ? Center(child: Text("No favorite recipes"))
              : ListView.builder(
                itemCount: favoritesRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = favoritesRecipes[index];
                  return favoriteRecipesCard(recipe: recipe);
                },
              );
        },
      ),
    );
  }
}

class favoriteRecipesCard extends StatelessWidget {
  final Recipe recipe;
  const favoriteRecipesCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipesData: recipe),
            ),
          ),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(recipe.nombre),
            Text(recipe.author),
            Text("Hola mama"),
            Text("Hola mama"),
          ],
        ),
      ),
    );
  }
}
