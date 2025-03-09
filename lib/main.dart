import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/screens/home_screen.dart';

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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Recipe Book", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [Tab(icon: Icon(CupertinoIcons.home), text: "Home")],
          ),
        ),
        body: TabBarView(children: <Widget>[HomeScreen()]),
      ),
    );
  }
}
