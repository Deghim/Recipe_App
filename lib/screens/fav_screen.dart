import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue, child: Icon(CupertinoIcons.heart));
  }
}
