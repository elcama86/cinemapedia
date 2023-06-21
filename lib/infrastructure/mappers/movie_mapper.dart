import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: movieDb.backdropPath != ""
            ? "https://image.tmdb.org/t/p/w500${movieDb.backdropPath}"
            : "https://sd.keepcalms.com/i/keep-calm-poster-not-found.png",
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: movieDb.posterPath != ""
            ? "https://image.tmdb.org/t/p/w500${movieDb.posterPath}"
            : "https://www.movienewz.com/img/films/poster-holder.jpg",
        releaseDate: movieDb.releaseDate ?? DateTime.now(),
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
        adult: movieDetails.adult,
        backdropPath: movieDetails.backdropPath != ""
            ? "https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}"
            : "https://sd.keepcalms.com/i/keep-calm-poster-not-found.png",
        genreIds: movieDetails.genres.map((g) => g.name.toString()).toList(),
        id: movieDetails.id,
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        overview: movieDetails.overview,
        popularity: movieDetails.popularity,
        posterPath: movieDetails.posterPath != ""
            ? "https://image.tmdb.org/t/p/w500${movieDetails.posterPath}"
            : "https://www.movienewz.com/img/films/poster-holder.jpg",
        releaseDate: movieDetails.releaseDate ?? DateTime.now(),
        title: movieDetails.title,
        video: movieDetails.video,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount,
      );
}
