import 'package:moviecatalogue/configs/config.dart';

class MdbEndpoints {
  static const String getMovieDiscover = '/discover/movie?api_key=${Configurations.mdbApiKey}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate';
  static const String getTvDiscover = '/pokemon-color';
}
