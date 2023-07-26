import 'dart:convert';

import 'package:flutter_movies/models/models.dart';

class MovieSearchResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MovieSearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieSearchResponse.fromRawJson(String str) =>
      MovieSearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) =>
      MovieSearchResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
