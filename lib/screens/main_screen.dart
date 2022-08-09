import 'package:flutter/material.dart';
import 'package:moviecatalogue/data/datasource.dart';
import 'package:moviecatalogue/models/movie_model.dart';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/screens/detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const MobileView();
          } else {
            return const DesktopView();
          }
        },
      ),
    );
  }
}

class DesktopView extends StatefulWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 38.0, top: 27.0, left: 16.0, right: 16.0),
          child: Text('Discover', style: Theme.of(context).textTheme.headline1),
        ),
        FutureMoviesGrid(
          movieList: futureMovieNowPlayingList,
          sectionTitle: 'Now Playing',
        ),
        const SizedBox(height: 34.0),
        FutureMoviesGrid(
          movieList: futureMovieTopRatedList,
          sectionTitle: 'Top Rated',
        ),
      ],
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
                FutureHorizontalMoviesList(
                  movieList: futureMovieNowPlayingList,
                  sectionTitle: 'Now Playing',
                ),
                FutureHorizontalMoviesList(
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

class FutureHorizontalMoviesList extends StatelessWidget {
  final Future<List<MovieModel>> movieList;
  final String sectionTitle;

  const FutureHorizontalMoviesList(
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final MovieModel currentMovie = snapshot.data![index];

                    return MovieCard(movie: currentMovie);
                  },
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

class FutureMoviesGrid extends StatelessWidget {
  final Future<List<MovieModel>> movieList;
  final String sectionTitle;

  const FutureMoviesGrid(
      {Key? key, required this.movieList, required this.sectionTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: movieList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(sectionTitle,
                    style: Theme.of(context).textTheme.headline2),
              ),
              Wrap(
                spacing: 6.0,
                direction: Axis.horizontal,
                children: snapshot.data!.map((movie) {
                  return MovieCard(movie: movie, width: 175);
                }).toList(),
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
  final double? width;

  const MovieCard({Key? key, required this.movie, this.width = 150.0})
      : super(key: key);
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
          width: width,
          height: width! * 1.5,
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
