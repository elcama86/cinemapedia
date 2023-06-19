import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';

// Este repositorio es inmutable
final moviesRepositoryProvider = Provider<MoviesRepositoryImpl>(
  (ref) => MoviesRepositoryImpl(
    MovieDbDatasource(),
  ),
);
