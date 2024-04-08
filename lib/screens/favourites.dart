import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  final String name;
  final String rating;
  final String imagePath;

  const FavouritesPage({
    Key? key,
    required this.name,
    required this.rating,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Text(rating),
            Image.asset(imagePath),
            // Display other vendor information as needed
          ],
        ),
      ),
    );
  }
}
