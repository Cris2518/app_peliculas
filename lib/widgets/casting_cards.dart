import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  
  const CastingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25, bottom: 10),
          child: Text('Reparto', 
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: ( _ , index) => _CastCard(),
          ),
        ),
      ],
    );
  }
}

class _CastCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 120,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage('https://placehold.co/150x300.png'),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 5),

          Text(
            'actor.name', 
            maxLines: 2, 
            overflow: TextOverflow.ellipsis, 
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}