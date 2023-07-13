import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorMovieKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellMovie');
final _shellNavigatorCategoriesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellCategories');
final _shellNavigatorFavoritesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFavorites');

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
              pageBuilder: (context, state) => transitionAnimationPage(
                key: state.pageKey,
                child: const HomeView(),
              ),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  parentNavigatorKey: _rootNavigatorKey,
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';

                    return MovieScreen(
                      movieId: movieId,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCategoriesKey,
          routes: [
            GoRoute(
              path: '/popular',
              pageBuilder: (context, state) => transitionAnimationPage(
                key: state.pageKey,
                child: const PopularView(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavoritesKey,
          routes: [
            GoRoute(
              path: '/favorites',
              pageBuilder: (context, state) => transitionAnimationPage(
                key: state.pageKey,
                child: const FavoritesView(),
              ),
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
  Duration duration = const Duration(milliseconds: 500),
}) {
  return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
