import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorMovieKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellMovie');

final appRouter = GoRouter(
  initialLocation: "/",
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMovieKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  parentNavigatorKey: _rootNavigatorKey,
                  name: MovieScreen.name,
                  pageBuilder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';

                    return transitionAnimationPage(
                      key: state.pageKey,
                      child: MovieScreen(
                        movieId: movieId,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/popular',
              builder: (context, state) => const PopularView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView(),
            ),
          ],
        ),
      ],
    ),

    // Rutas padre/hijo
    // GoRoute(
    //   path: "/",
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(
    //     childView: FavoritesView(),
    //   ),
    //   routes: [
    //     GoRoute(
    //       path: "movie/:id",
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? "no-id";

    //         return MovieScreen(
    //           movieId: movieId,
    //         );
    //       },
    //     ),
    //   ],
    // ),
  ],
);

CustomTransitionPage<void> transitionAnimationPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      });
}
