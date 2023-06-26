import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';

final localStorageRepositoryProvider = Provider<LocalStorageRepositoryImpl>(
  (ref) => LocalStorageRepositoryImpl(
    IsarDatasource(),
  ),
);
