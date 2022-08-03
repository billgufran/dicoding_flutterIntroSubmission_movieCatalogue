import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie List')),
      body: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MovieListMobile extends StatelessWidget {
  const MovieListMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie List')),
      body: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
