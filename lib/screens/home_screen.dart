import 'package:flutter/material.dart';
import 'package:mis_peliculas/providers/movies_provider.dart';
import 'package:mis_peliculas/search/search_delegate.dart';
import 'package:mis_peliculas/widgets/widgets.dart' show CardSwiper, MovieSlider;
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
            icon: Icon(Icons.search_rounded),
            onPressed: () => showSearch(
              context: context, 
              delegate: MovieSearchDelegate()
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwiper( movies: moviesProvider.onDisplayMovies ),
            // Slider de peliculas
            MovieSlider( 
              popularMovies: moviesProvider.popularMovies, 
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies()
            )
          ],
        ),
      ),
    );
  }
}