import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

final favoritesMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(
    localStorageReposity: localStorageRepository,
  );
});

/*
  {
    1234: Movie(),
    1235: Movie(),
    .
    .
    .
  }
*/

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageReposity localStorageReposity;

  StorageMoviesNotifier({
    required this.localStorageReposity,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageReposity.loadMovies(offset: page * 10, limit: 20);
    page++;

    final Map<int, Movie> tempMoviesMap = {};

    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageReposity.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
