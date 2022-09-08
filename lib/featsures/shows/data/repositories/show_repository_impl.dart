import 'package:amazing_tv/core/error/fialures.dart';
import 'package:amazing_tv/featsures/shows/data/datasources/show_locale_datasource.dart';
import 'package:amazing_tv/featsures/shows/data/datasources/show_remote_datasource.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/episode.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/season.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/show.dart';
import 'package:amazing_tv/featsures/shows/domain/repositories/show_repository.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_is_favourites.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_search_seasons.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_toggle_favourites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';

class ShowRepositoryImpl extends ShowRepository{

  final ShowRemoteDataSource remoteDataSource;
  final ShowLocaleDataSource localeDataSource;


  ShowRepositoryImpl({required this.remoteDataSource,required this.localeDataSource});

  @override
  Future<Either<Failure, List<Show>>> getAllShows({required int pageNumber})async {
    try{
      final remoteShows = await remoteDataSource.getAllShows(pageNumber: pageNumber);
      return Right(remoteShows);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Season>>> getAllShowSeasons({required String showId}) async{
    try{
      final remoteShowSeasons = await remoteDataSource.getAllShowSeasons(id: showId);
      return Right(remoteShowSeasons);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getAllSeasonEpisodes({required String seasonId})async {
    try{
      final remoteSeasonEpisodes = await remoteDataSource.getAllSeasonEpisodes(seasonId: seasonId);
      return Right(remoteSeasonEpisodes);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Show?>>> getAllFavourites() async {
    try {
      final localeFavourites = await localeDataSource.getAllFavourites();
      return Right(localeFavourites);
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isFavourites(
      IsFavouritesParameters parameters) async {
    try {
      final localeFavourites = await localeDataSource.isFavourites(parameters);
      return Right(localeFavourites);
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Show?>>> toggleFavourites(
      ToggleFavouritesParameters parameters) async {
    try {
      final localeFavourites =
      await localeDataSource.toggleFavourites(parameters);
      return Right(localeFavourites);
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Show>>> getSearch(
      SearchParameters parameters) async {
    try {
      final remoteShows = await remoteDataSource.getSearch(parameters);
      return Right(remoteShows);
    } on ServerException {
      return Left(ServerFailure());
    }
  }







}