import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              ? Center(child: Text(AppLocalizations.of(context)!.noRecipes))
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
      child: Semantics(
        label: "Recipe card",
        hint: "Tap to see details ${recipe.nombre}",
        child: Card(
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 125,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(recipe.image_link, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20),
              Column(children: [Text(recipe.nombre), Text(recipe.author)]),
            ],
          ),
        ),
      ),
    );
  }
}
