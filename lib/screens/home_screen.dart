import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movies/providers/providers.dart';
import 'package:flutter_movies/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiperWidget(
              nowPlayingMovies: movieProvider.nowPlayingMovies,
            ),
            MovieSlider(
              popularMovies: movieProvider.popularMovies,
              onNextPage: () => movieProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
