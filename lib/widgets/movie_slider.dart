import 'package:flutter/material.dart';
import 'package:mis_peliculas/models/models.dart' show Movie;
import 'package:mis_peliculas/providers/movies_provider.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> popularMovies;
  final String ? title;
  final Function onNextPage;

  const MovieSlider({
    super.key, 
    required this.popularMovies, 
    required this.onNextPage,
    this.title, 
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();
  final MoviesProvider moviesProvider = MoviesProvider();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if(scrollController.position.pixels + 50 >= scrollController.position.maxScrollExtent){
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),

          SizedBox(height: 7),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.popularMovies.length,
                itemBuilder: (_, int index) => _MoviePoster(movie: widget.popularMovies[index], heroId: '${widget.title}-$index-${widget.popularMovies[index].id}',)
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MoviePoster({
    required this.movie,
    required this.heroId
  });

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
