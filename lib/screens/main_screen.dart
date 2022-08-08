import 'package:flutter/material.dart';
import 'package:moviecatalogue/data/datasource.dart';
import 'package:moviecatalogue/models/movie_model.dart';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/screens/detail_screen.dart';

var h1 = const TextStyle(
  fontSize: 39,
  fontWeight: FontWeight.bold,
  fontFamily: 'RobotoCondensed',
  letterSpacing: 0.2,
);

var h2 = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'RobotoCondensed',
);

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
        Text('Discover', style: h1),
        FutureBuilder<List<MovieModel>>(
          future: movieDiscoveryList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Movies', style: h2),
                  SizedBox(
                    height: 300,
                    child: Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          var currentMovie = snapshot.data![index];

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
      padding: const EdgeInsets.all(7),
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
