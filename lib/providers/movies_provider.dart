import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '804d5a8f7e868f661a2c54e2a81f796d';
  final String _languaje = 'es-ES';

  List<Movie> onDisplayMovies = [];

  MoviesProvider(){
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
  }

  getOnDisplayMovies() async{

    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': '1'
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

}

