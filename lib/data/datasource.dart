import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/data/constants.dart';
import 'package:moviecatalogue/models/movie_model.dart';


Future<MovieModel> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('${Config.mdbApiHost}${MdbEndpoints.movieDiscoverPath}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    // return MovieModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}