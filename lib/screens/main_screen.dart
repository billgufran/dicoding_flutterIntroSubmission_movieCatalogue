import 'package:flutter/material.dart';
import 'package:moviecatalogue/data/datasource.dart';
import 'package:moviecatalogue/models/movie_model.dart';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/screens/detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<MovieModel>> futureMovieDiscoveryList;

  @override
  void initState() {
    super.initState();
    futureMovieDiscoveryList = fetchMovieDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureMobileView(
        movieDiscoveryList: futureMovieDiscoveryList,
      ),
    );
  }
}

class FutureMobileView extends StatelessWidget {
  final Future<List<MovieModel>> movieDiscoveryList;

  const FutureMobileView({Key? key, required this.movieDiscoveryList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 32.0, top: 24.0, left: 16.0, right: 16.0),
          child: Text('Discover', style: Theme.of(context).textTheme.headline1),
        ),
        FutureBuilder<List<MovieModel>>(
          future: movieDiscoveryList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    child: Text('Movies',
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
        ),
      ],
    ));
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
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
