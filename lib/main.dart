import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hola mundo",
      home: RecipeBook(),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Book", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Container(
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
                  borderRadius: BorderRadius.circular(10),
                  child: Container(),
                ),
              ),
              SizedBox(width: 20),
              Column(
                children: <Widget>[
                  Text("Lasagna"),
                  Text("Jorge U. Chavira"),
                  Container(height: 1, width: 75, color: Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
