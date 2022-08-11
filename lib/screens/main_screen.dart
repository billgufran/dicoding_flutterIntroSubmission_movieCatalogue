import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalogue/Widgets/custom_app_bar.dart';
import 'package:moviecatalogue/data/datasource.dart';
import 'package:moviecatalogue/models/movie_model.dart';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/screens/detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return const MobileView();
        } else {
          return const DesktopView();
        }
      },
    );
  }
}

class DesktopView extends StatefulWidget {
  const DesktopView({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  late Future<List<MovieModel>> futureMovieNowPlayingList;
  late Future<List<MovieModel>> futureMovieTopRatedList;

  /**
   * It is intentional to put API call inside initState instead of build methot
   * as recommended in Flutter docs, hence DesktopView needs to be a StatefulWidget.
   *
   * https://docs.flutter.dev/cookbook/networking/fetch-data#why-is-fetchalbum-called-in-initstate
   */
  @override
  void initState() {
    super.initState();
    futureMovieNowPlayingList = fetchMovieNowPlaying();
    futureMovieTopRatedList = fetchMovieTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 38.0),
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
      ),
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

  /**
   * It is intentional to put API call inside initState instead of build methot
   * as recommended in Flutter docs, hence MobileView needs to be a StatefulWidget.
   *
   * https://docs.flutter.dev/cookbook/networking/fetch-data#why-is-fetchalbum-called-in-initstate
   */
  @override
  void initState() {
    super.initState();
    futureMovieNowPlayingList = fetchMovieNowPlaying();
    futureMovieTopRatedList = fetchMovieTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/**
 * FutureHorizontalMoviesList has a ScrollController, hence it needs to be a StatefulWidget.
 *
 * ref:
 * https://stackoverflow.com/questions/61123348/scrollcontroller-in-statelesswidget
 * https://github.com/piedcipher/beer-app/issues/2
 *
 */
class FutureHorizontalMoviesList extends StatefulWidget {
  final Future<List<MovieModel>> movieList;
  final String sectionTitle;

  const FutureHorizontalMoviesList(
      {Key? key, required this.movieList, required this.sectionTitle})
      : super(key: key);

  @override
  State<FutureHorizontalMoviesList> createState() =>
      _FutureHorizontalMoviesListState();
}

class _FutureHorizontalMoviesListState
    extends State<FutureHorizontalMoviesList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    const itemCount = 7;

    return FutureBuilder<List<MovieModel>>(
      future: widget.movieList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Text(widget.sectionTitle,
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(
                height: 300,
                child: DesktopScrollbar(
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final MovieModel currentMovie = snapshot.data![index];

                      return Padding(
                        padding: index == itemCount - 1
                            ? const EdgeInsets.symmetric(horizontal: 16.0)
                            : const EdgeInsets.only(left: 16.0),
                        child: MovieCard(
                          movie: currentMovie,
                          width: 150.0,
                        ),
                      );
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class FutureMoviesGrid extends StatelessWidget {
  final Future<List<MovieModel>> movieList;
  final String sectionTitle;

  const FutureMoviesGrid({
    Key? key,
    required this.movieList,
    required this.sectionTitle,
  }) : super(key: key);

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
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(sectionTitle,
                    style: Theme.of(context).textTheme.headline2),
              ),
              GridView.extent(
                  scrollDirection: Axis.vertical,
                  childAspectRatio: 0.5, //680 - 820
                  shrinkWrap: true,
                  maxCrossAxisExtent: 216,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: snapshot.data!.map(
                    (movie) {
                      return MovieCard(
                        movie: movie,
                        width: 200,
                      );
                    },
                  ).toList()),
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

  const MovieCard({
    Key? key,
    required this.movie,
    this.width = 150.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width! * 2,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailScreen(movie: movie);
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${Config.mdbImageHost}/w342${movie.posterPath}',
                fit: BoxFit.cover,
                width: width,
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
    );
  }
}

class DesktopScrollbar extends StatelessWidget {
  final ScrollController controller;
  final Widget child;

  const DesktopScrollbar(
      {Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = !kIsWeb ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;

    return isMobile
        ? child
        : Scrollbar(
            controller: controller,
            child: child,
          );
  }
}
