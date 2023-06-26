import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const ActorsByMovie({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return Container(
        height: 100.0,
        margin: const EdgeInsets.only(bottom: 50.0),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Foto de perfil
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      height: 180.0,
                      width: 135.0,
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage('assets/loaders/bottle-loader.gif'),
                      image: NetworkImage(
                        actor.profilePath,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                // Nombre
                Text(
                  actor.name,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                ),
                // Personaje
                Text(
                  actor.character ?? "",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
