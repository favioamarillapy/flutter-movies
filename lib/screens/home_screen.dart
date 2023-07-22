import 'package:flutter/material.dart';
import 'package:flutter_movies/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CardSwiperWidget(),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
