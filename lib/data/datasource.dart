import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/data/constants.dart';
import 'package:moviecatalogue/models/movie_model.dart';

Future<List<MovieModel>> fetchMovieNowPlaying() async {
  final response = await http.get(
      Uri.parse('${Config.mdbApiHost}${MdbEndpoints.movieNowPlayingPath}'));

  if (response.statusCode == 200) {
    final responseResults = jsonDecode(response.body)['results'];

    return responseResults
        .map<MovieModel>((json) => MovieModel.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<List<MovieModel>> fetchMovieTopRated() async {
  final response = await http
      .get(Uri.parse('${Config.mdbApiHost}${MdbEndpoints.movieTopRatedPath}'));

  if (response.statusCode == 200) {
    final responseResults = jsonDecode(response.body)['results'];

    return responseResults
        .map<MovieModel>((json) => MovieModel.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load movies');
  }
}
