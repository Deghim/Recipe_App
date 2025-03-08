import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_RecipesCard(context), _RecipesCard(context)],
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

  Widget _RecipesCard(BuildContext context) {
    return Padding(
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
                    'https://static.platzi.com/media/uploads/flutter_lasana_b894f1aee1.jpg',
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
                    "Lasagna",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(height: 1, width: 75, color: Colors.green),
                  SizedBox(height: 4),
                  Text(
                    "Jorge U. Chavira",
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                ],
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        // key: _FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Recipe',
              style: TextStyle(color: Colors.green, fontSize: 24),
            ),
            SizedBox(height: 16),
            _buildTextField(label: 'Recipe Name'),
            SizedBox(height: 8),
            _buildTextField(label: 'Author '),
            SizedBox(height: 8),
            _buildTextField(label: 'Img URL'),
            SizedBox(height: 8),
            _buildTextField(label: 'Recipe'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label}) {
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
    );
  }
}
