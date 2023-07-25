import 'package:flutter/material.dart';
import 'package:flutter_movies/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> popularMovies;
  final Function onNextPage;

  const MovieSlider({
    super.key,
    required this.popularMovies,
    required this.onNextPage,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController _scrollController = new ScrollController();
  bool _canGetMore = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final double diff = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;

      if (diff <= 500) {
        if (_canGetMore) {
          _canGetMore = false;
          widget.onNextPage();
        }
      } else {
        _canGetMore = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.popularMovies.length,
              itemBuilder: (context, index) =>
                  _MovieCard(movie: widget.popularMovies[index]),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, "detail", arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(movie.fullPosterPath! ??
                    "https://via.placeholder.com/300x400"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            movie.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
