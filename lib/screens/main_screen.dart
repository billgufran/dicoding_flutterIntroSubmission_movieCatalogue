import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie List')),
      body: const MovieListMobile(),
    );
  }
}

class MovieListMobile extends StatelessWidget {
  const MovieListMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('This is the list of the movies'),
      ],
    );
  }
}
