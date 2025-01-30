import 'dart:convert';

class Movie {
    bool adult;
    String ? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String ? posterPath;
    DateTime ? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    get fullPosterImg {
      if (posterPath != null) {
        return 'https://image.tmdb.org/t/p/w500$posterPath';
      } else {
        return 'https://static.vecteezy.com/system/resources/previews/016/808/173/original/camera-not-allowed-no-photography-image-not-available-concept-icon-in-line-style-design-isolated-on-white-background-editable-stroke-vector.jpg';
      }
    }

    get fullBackDropPath {
      if (posterPath != null) {
        return 'https://image.tmdb.org/t/p/w500$backdropPath';
      } else {
        return 'https://static.vecteezy.com/system/resources/previews/016/808/173/original/camera-not-allowed-no-photography-image-not-available-concept-icon-in-line-style-design-isolated-on-white-background-editable-stroke-vector.jpg';
      }
    }

    Movie({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult            : json["adult"],
        backdropPath     : json["backdrop_path"],
        genreIds         : List<int>.from(json["genre_ids"].map((x) => x)),
        id               : json["id"],
        originalLanguage : json["original_language"]!,
        originalTitle    : json["original_title"],
        overview         : json["overview"],
        popularity       : json["popularity"]?.toDouble(),
        posterPath       : json["poster_path"],
        releaseDate      : DateTime.parse(json["release_date"]),
        title            : json["title"],
        video            : json["video"],
        voteAverage      : json["vote_average"]?.toDouble(),
        voteCount        : json["vote_count"],
    );
}
