import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_peliculas/helpers/debouncer.dart';
import 'package:mis_peliculas/models/models.dart';
import 'package:mis_peliculas/models/search_movies_response.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '804d5a8f7e868f661a2c54e2a81f796d';
  final String _languaje = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
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

  Future<List<Cast>> getMovieCast( int movieId) async {

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final creditsResponse = CreditsResponse.fromJson(await _getJsonData('3/movie/$movieId/credits'));

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _languaje,
      'query': query
    });

    final response = await http.get(url);

    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){

    debouncer.value = '';
    debouncer.onValue = (value) async {

      final results = await this.searchMovie(value);

      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) => debouncer.value = searchTerm);

    Future.delayed(Duration(milliseconds: 301)).then(( _ ) => timer.cancel());

  }

}

