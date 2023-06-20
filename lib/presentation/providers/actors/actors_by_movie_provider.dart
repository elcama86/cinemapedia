import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;

  return ActorsByMovieNotifier(
    getActors: getActors,
  );
});

/*
  {
    "1": List<Actor>[],
    "2": List<Actor>[],
    "3": List<Actor>[],
  }
*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    // Se verifica si el listado de actores de la pelicula ya fue cargado (verificación del cache) {movieId: List<Actor>[]}
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
