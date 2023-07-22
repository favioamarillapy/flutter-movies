import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

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
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) => const _MovieCard(),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "detail",
                arguments: "movie-instance"),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage("assets/no-image.jpg"),
                image: NetworkImage("https://via.placeholder.com/300x400"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            "Description asdasdasdasd",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
