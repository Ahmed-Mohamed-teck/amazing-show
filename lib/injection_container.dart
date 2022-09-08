import 'package:amazing_tv/core/resources/constants_manager.dart';
import 'package:amazing_tv/featsures/shows/data/datasources/show_locale_datasource.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_all_show_seasons.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/episode/episode_bloc.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/season/season_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'featsures/shows/data/datasources/show_remote_datasource.dart';
import 'featsures/shows/data/repositories/show_repository_impl.dart';
import 'featsures/shows/domain/repositories/show_repository.dart';
import 'featsures/shows/domain/usecases/get_all_favourites.dart';
import 'featsures/shows/domain/usecases/get_all_season_episodes.dart';
import 'featsures/shows/domain/usecases/get_all_shows.dart';
import 'featsures/shows/domain/usecases/get_is_favourites.dart';
import 'featsures/shows/domain/usecases/get_search_seasons.dart';
import 'featsures/shows/domain/usecases/get_toggle_favourites.dart';
import 'featsures/shows/presentation/bloc/favourites/favourites_bloc.dart';
import 'featsures/shows/presentation/bloc/search/search_bloc.dart';
import 'featsures/shows/presentation/bloc/show/show_bloc.dart';


final sl =GetIt.instance;


Future<void> init()async{

  ///Features - Posts
  //bloc
  sl.registerLazySingleton(() => ShowBloc(getAllShowsUseCase: sl()));
  sl.registerFactory(() => SeasonBloc(getAllShowSeasonsUseCase: sl(),));
  sl.registerFactory(() => EpisodeBloc(getAllSeasonEpisodesUseCase: sl(),));
  sl.registerFactory(() => FavouritesBloc(
      getAllFavouritesUseCase: sl(),
      getIsFavouritesUseCase: sl(),
      getToggleFavouritesUseCase: sl()));
  sl.registerLazySingleton(() => SearchBloc(getSearchUseCase: sl()));

// UseCases
  sl.registerLazySingleton(() => GetAllShowsUseCase(sl()));
  sl.registerLazySingleton(() => GetAllShowSeasonsUseCase(sl()));
  sl.registerLazySingleton(() => GetAllSeasonEpisodesUseCase(sl()));
  sl.registerLazySingleton(() => GetAllFavouritesUseCase(sl()));
  sl.registerLazySingleton(() => GetToggleFavouritesUseCase(sl()));
  sl.registerLazySingleton(() => GetIsFavouritesUseCase(sl()));
  sl.registerLazySingleton(() => GetSearchUseCase(sl()));


// Repository
  sl.registerLazySingleton<ShowRepository>(() => ShowRepositoryImpl(remoteDataSource: sl(),localeDataSource: sl()));

// Datasources
  sl.registerLazySingleton<ShowRemoteDataSource>(() => ShowRemoteDataSourceImpl());
  sl.registerLazySingleton<ShowLocaleDataSource>(() => ShowLocaleDataSourceImpl());







  /// core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));


  /// External
  final sharedPreferences =await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());


  /// create app folder & init local storage
  await FileHelper.createAppFolder();
  final localStorage = LocalStorage(LocalStorageKey.app);
  await localStorage.ready;
  sl.registerSingleton<LocalStorage>(localStorage);



}