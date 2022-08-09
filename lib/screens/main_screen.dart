import 'package:flutter/material.dart';
import 'package:moviecatalogue/data/datasource.dart';
import 'package:moviecatalogue/models/movie_model.dart';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/screens/detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MobileView(),
    );
  }
}

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  late Future<List<MovieModel>> futureMovieNowPlayingList;
  late Future<List<MovieModel>> futureMovieTopRatedList;

  @override
  void initState() {
    super.initState();
    futureMovieNowPlayingList = fetchMovieNowPlaying();
    futureMovieTopRatedList = fetchMovieTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 32.0, top: 24.0, left: 16.0, right: 16.0),
              child: Text('Discover',
                  style: Theme.of(context).textTheme.headline1),
            ),
            Column(
              children: [
                FutureHorizontalMovieList(
                  movieList: futureMovieNowPlayingList,
                  sectionTitle: 'Now Playing',
                ),
                FutureHorizontalMovieList(
                  movieList: futureMovieTopRatedList,
                  sectionTitle: 'Top Rated',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FutureHorizontalMovieList extends StatelessWidget {
  final Future<List<MovieModel>> movieList;
  final String sectionTitle;

  const FutureHorizontalMovieList(
      {Key? key, required this.movieList, required this.sectionTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: movieList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Text(sectionTitle,
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(
                height: 300,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final MovieModel currentMovie = snapshot.data![index];

                      return MovieCard(movie: currentMovie);
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailScreen(movie: movie);
          }));
        },
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${Config.mdbImageHost}/w342${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                movie.title ?? "title",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                movie.releaseDate?.split('-')[0] ?? "subtitle",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
