import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_book/screens/recipe_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> FetchRecipes() async {
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
        return data['recetas'];
      } else {
        debugPrint('Error ${response.statusCode}');
        return [];
      }
    } on Exception catch (e) {
      debugPrint("Error in the request");
      return [];
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: FetchRecipes(),
        builder: (context, snapshot) {
          final recipes = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No available recipes"));
          } else {
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return _RecipesCard(context, recipes[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(CupertinoIcons.add, color: Colors.white),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (contexto) {
        return Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: RecipeForm(),
        );
      },
    );
  }

  Widget _RecipesCard(BuildContext context, dynamic recip) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipeName: recip['nombre']),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width:
              MediaQuery.of(context)
                  .size
                  .width, // MediaQuery.of(context)... proporciona datos sobre el tamaño de la pantalla, la orientación, la densidad de píxeles, los márgenes seguros (safe areas), la escala del texto y otros aspectos del diseño.
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      recip['imagen_url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recip['nombre'],
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(height: 1, width: 75, color: Colors.green),
                    SizedBox(height: 4),
                    Text(
                      recip['autor'],
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeIMG = TextEditingController();
    final TextEditingController _recipeDescritio = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Recipe',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildTextField(
                controller: _recipeName,
                label: 'Recipe Name',
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Invalid Input"
                      : null;
                },
              ),
              SizedBox(height: 4),
              _buildTextField(
                controller: _recipeAuthor,
                label: 'Author ',
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Invalid Input"
                      : null;
                },
              ),
              SizedBox(height: 4),
              _buildTextField(
                controller: _recipeIMG,
                label: 'Img URL',
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Invalid Input"
                      : null;
                },
              ),
              SizedBox(height: 4),
              _buildTextField(
                controller: _recipeDescritio,
                label: 'Recipe',
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Invalid Input"
                      : null;
                },
                maxLines: 4,
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Save Recipe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: 'Quicksand', color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      controller: controller,
      maxLines: maxLines,
    );
  }
}
