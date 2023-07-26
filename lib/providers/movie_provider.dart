import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_search_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movies/models/models.dart';

class MovieProvider extends ChangeNotifier {
  final String _apiey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNTA5NDEzMjdkNTI3ZWRiNWEwOTJkMjFkYTM4YzgyNCIsInN1YiI6IjYzNTJjZmUzZDhlMjI1MDA3ZDk4Y2EzOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ji_xDyFhXb7gjzz3BP66ueA4XNKHfzmZwxl1uZ6VoV4";
  final String _baseUrl = 'api.themoviedb.org';

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> castings = {};

  int _popularPage = 0;

  MovieProvider() {
    getNowPlaying();
    getPopularMovies();
  }

  getNowPlaying() async {
    final url = Uri.https(_baseUrl, '/3/movie/now_playing', {"page": "1"});
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_apiey',
      'accept': 'application/json'
    });

    nowPlayingMovies = NowPlayingResponse.fromRawJson(response.body).results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final url =
        Uri.https(_baseUrl, '/3/movie/popular', {"page": "$_popularPage"});
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_apiey',
      'accept': 'application/json'
    });

    popularMovies = [
      ...popularMovies,
      ...PopularResponse.fromRawJson(response.body).results
    ];

    notifyListeners();
  }

  Future<List<Cast>> getCastings(int movieId) async {
    if (castings.containsKey(movieId)) {
      return castings[movieId]!;
    }

    final url = Uri.https(_baseUrl, '/3/movie/$movieId/credits');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_apiey',
      'accept': 'application/json'
    });

    final creditsResponse = CreditsResponse.fromRawJson(response.body);

    castings[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> sarchMovie(String query) async {
    if (query == "") {
      return [];
    }

    final url = Uri.https(_baseUrl, '/3/search/movie', {"query": query});
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_apiey',
      'accept': 'application/json'
    });

    final movieSearchResponse = MovieSearchResponse.fromRawJson(response.body);

    return movieSearchResponse.results;
  }
}
