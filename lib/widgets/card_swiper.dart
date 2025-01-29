import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:mis_peliculas/models/models.dart';

class CardSwiper extends StatelessWidget {
   
  final List<Movie> movies;

  const CardSwiper({
    super.key, 
    required this.movies
  });
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return  SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child:  Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: ( _ , index) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movies[index].fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      );
  }
}