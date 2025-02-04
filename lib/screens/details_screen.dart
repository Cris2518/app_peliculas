import 'package:flutter/material.dart';
import 'package:mis_peliculas/models/models.dart';
import 'package:mis_peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  
  const DetailsScreen({super.key});
   
  //  Todo: cambia luego por una instacia de Movie

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie),
              _Overview(body: movie.overview),
              CastingCards( moveId: movie.id,)
            ])
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
          width: double.infinity,
          color: Colors.black38,
          alignment: Alignment.bottomCenter,
          child: Text(movie.title, style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,),
        ),
        centerTitle: true,
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackDropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),

          SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headlineSmall, overflow:TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalTitle, style: textTheme.bodyLarge, overflow:TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(movie.voteAverage.toString(), style: textTheme.labelMedium)
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {

  final String body;

  const _Overview({
    required this.body
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text(body,
      textAlign: TextAlign.justify,
      style: TextTheme.of(context).bodyLarge,),
    );
  }
}


