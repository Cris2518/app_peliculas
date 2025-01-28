import 'package:flutter/material.dart';
import 'package:mis_peliculas/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.search_rounded)
          )
        ],
      ),
      body: Column(
        children: [

          // Todo Card Swiper
          CardSwiper()

          // Todo: Listado horizontal

        ],
      )
    );
  }
}