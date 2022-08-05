import 'package:moviecatalogue/configs/config.dart';

class MdbEndpoints {
  static String movieDiscoverPath =
      '/discover/movie?api_key=${Config.mdbApiKey}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate';
  static String tvDiscoverPath =
      '/discover/tv?api_key=${Config.mdbApiKey}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0';
}
