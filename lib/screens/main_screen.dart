import 'package:flutter/material.dart';
import 'package:moviecatalogue/data/datasource.dart';
import 'package:moviecatalogue/models/movie_model.dart';
import 'package:moviecatalogue/configs/config.dart';

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
      appBar: AppBar(title: const Text('Movie List')),
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
    return Center(
      child: FutureBuilder<List<MovieModel>>(
        future: movieDiscoveryList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                const Text('Movie List'),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var currentMovie = snapshot.data![index];

                      print('${Config.mdbImageHost}${currentMovie.posterPath}');

                      return ListTile(
                        title: Text(currentMovie.title ?? "title"),
                        subtitle: Text(currentMovie.overview ?? "subtitle"),
                        leading: Image.network(
                          'https://media-cdn.tripadvisor.com/media/photo-s/0d/7c/59/70/farmhouse-lembang.jpg',
                          fit: BoxFit.cover,
                        ),
                      );
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
      ),
    );
  }
}
