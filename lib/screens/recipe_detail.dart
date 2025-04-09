import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipesData;
  const RecipeDetail({super.key, required this.recipesData});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(
      context,
      listen: false,
    ).favoriteRecipe.contains(widget.recipesData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipesData.nombre,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<RecipesProvider>(
                context,
                listen: false,
              ).toggleFavoriteStatus(widget.recipesData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: Colors.white,
                key: ValueKey<bool>(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Image.network(widget.recipesData.image_link),
            Text(widget.recipesData.nombre),
            SizedBox(height: 10),
            Text("by ${widget.recipesData.author}"),
            SizedBox(height: 10),
            const Text('Recipe steps: '),
            for (var step in widget.recipesData.recipeSteps) Text(step),
          ],
        ),
      ),
    );
  }
}
