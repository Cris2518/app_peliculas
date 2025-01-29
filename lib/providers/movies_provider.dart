import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '804d5a8f7e868f661a2c54e2a81f796d';
  final String _languaje = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _languaje,
      'page': '$page'
    });

    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {

    final nowPlayingResponse = NowPlayingResponse.fromJson(await _getJsonData('3/movie/now_playing'));

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final popularResponse = PopularResponse.fromJson(await _getJsonData('3/movie/popular', _popularPage));

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();

  }

}

