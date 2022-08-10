import 'package:flutter/material.dart';
import 'package:moviecatalogue/Widgets/custom_app_bar.dart';
import 'package:moviecatalogue/models/movie_model.dart';
import 'package:moviecatalogue/configs/config.dart';
import 'package:moviecatalogue/theme/colors.dart';

class DetailScreen extends StatelessWidget {
  final MovieModel movie;

  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return MobileView(movie: movie);
          } else {
            return DesktopView(movie: movie);
          }
        },
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  final MovieModel movie;

  const MobileView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingFavoriteButton(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${Config.mdbImageHost}/w780${movie.backdropPath}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: ShapeDecoration(
                color: CustomColors.backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
              ),
              transform: Matrix4.translationValues(0.0, -50.0, 0.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title!,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.releaseDate!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: CustomColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    movie.overview!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopView extends StatelessWidget {
  final MovieModel movie;

  const DesktopView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                '${Config.mdbImageHost}/original${movie.backdropPath}',
              ),
              colorFilter: ColorFilter.mode(
                CustomColors.backgroundColor.withOpacity(0.5),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${Config.mdbImageHost}/w342${movie.posterPath}',
                        fit: BoxFit.cover,
                        width: 300,
                        height: 300 * 1.5,
                      ),
                    ),
                    const SizedBox(width: 38.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                movie.title!,
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.textColor,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '(${movie.releaseDate!.split('-')[0]})',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w200,
                                  color: CustomColors.textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const FloatingFavoriteButton(),
                          const SizedBox(height: 25),
                          Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            movie.overview!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FloatingFavoriteButton extends StatefulWidget {
  const FloatingFavoriteButton({Key? key}) : super(key: key);

  @override
  State<FloatingFavoriteButton> createState() => _FloatingFavoriteButtonState();
}

class _FloatingFavoriteButtonState extends State<FloatingFavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Toggle favorite',
      child: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: CustomColors.accentColor,
      ),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
    );
  }
}
