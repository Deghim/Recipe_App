import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final String recipeName;
  const RecipeDetail({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipeName,
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
      ),
    );
  }
}
