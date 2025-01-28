import 'package:flutter/material.dart';
import 'package:mis_peliculas/providers/movies_provider.dart';
import 'package:mis_peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.search_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwiper( movies: moviesProvider.onDisplayMovies ),
            // Slider de peliculas
            MovieSlider()
          ],
        ),
      ),
    );
  }
}