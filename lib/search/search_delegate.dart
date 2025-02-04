
import 'package:flutter/material.dart';
import 'package:mis_peliculas/models/models.dart';
import 'package:mis_peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null), 
      icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildresults');
  }

  Widget _emptyContainer(){
    return Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty){
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovie(query), 
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot){

        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length ,
          itemBuilder:(_, index) => _MovieItem(movie: movies[index])
        );
      }
    );
  }

}


class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {

    movie.heroId = '${movie.title}-${movie.id}-${movie.originalTitle}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.fullPosterImg, scale: 1),
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}