import 'package:flutter/material.dart';
import 'package:flutter_movies/models/models.dart';
import 'package:flutter_movies/providers/providers.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search movie";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    if (query.isEmpty) {
      return _NoData();
    }

    return FutureBuilder(
      future: movieProvider.sarchMovie(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _NoData();
        }

        final movie = snapshot.data!;

        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: (context, index) => _SearchItem(movie: movie[index]),
        );
      },
    );
  }
}

class _NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.movie_creation,
        color: Colors.black38,
        size: 130,
      ),
    );
  }
}

class _SearchItem extends StatelessWidget {
  final Movie movie;

  const _SearchItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, "detail", arguments: movie),
      leading: FadeInImage(
        placeholder: const AssetImage("assets/no-image.jpg"),
        image: NetworkImage(movie.fullPosterPath),
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
    );
  }
}
