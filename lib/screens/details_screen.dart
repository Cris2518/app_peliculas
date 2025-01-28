import 'package:flutter/material.dart';
import 'package:mis_peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  //  Todo: cambia luego por una instacia de Movie

  @override
  Widget build(BuildContext context) {

  final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
  
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards()
            ])
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

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
          padding: EdgeInsets.only(bottom: 15),
          width: double.infinity,
          color: Colors.black38,
          alignment: Alignment.bottomCenter,
          child: Text('movie.title', style: TextStyle(fontSize: 16, color: Colors.white),),
        ),
        centerTitle: true,
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://placehold.co/500x300.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://placehold.co/300x400.png'),
              height: 150,
            ),
          ),

          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headlineMedium, overflow:TextOverflow.ellipsis, maxLines: 2),
              Text('movie.originalTitle', style: textTheme.bodyLarge, overflow:TextOverflow.ellipsis, maxLines: 1),
              
              Row(
                children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('movie.voteAverage', style: textTheme.labelMedium)
                ],
              )
            ],
          )

        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text('Do consectetur voluptate aliqua qui enim eiusmod aliqua ad. Exercitation ullamco ea et Lorem do enim velit quis. Aliqua dolor reprehenderit officia laborum. Voluptate aliqua nostrud cupidatat eiusmod amet mollit non sunt Lorem amet. Et Lorem Lorem Lorem velit labore aute reprehenderit do occaecat in qui consequat sit. Non labore cillum laboris culpa laboris duis.',
      textAlign: TextAlign.justify,
      style: TextTheme.of(context).bodyLarge,),
    );
  }
}


