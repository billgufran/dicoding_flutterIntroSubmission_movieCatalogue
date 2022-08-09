import 'package:moviecatalogue/configs/config.dart';

class MdbEndpoints {
  static String movieNowPlayingPath =
      '/movie/now_playing?api_key=${Config.mdbApiKey}&language=en-US&page=1';
  static String movieTopRatedPath =
      '/movie/top_rated?api_key=${Config.mdbApiKey}&language=en-US&page=1';
}
