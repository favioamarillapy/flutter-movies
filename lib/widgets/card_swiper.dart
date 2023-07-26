import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/models/models.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Movie> nowPlayingMovies;

  const CardSwiperWidget({
    super.key,
    required this.nowPlayingMovies,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: nowPlayingMovies.length,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.9,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          final Movie movie = nowPlayingMovies[index];
          movie.heroId = "swiper-${movie.id}";

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, "detail", arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(movie.fullPosterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
