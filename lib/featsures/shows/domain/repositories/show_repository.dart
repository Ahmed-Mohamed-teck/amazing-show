import 'package:amazing_tv/featsures/shows/domain/usecases/get_is_favourites.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_search_seasons.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_toggle_favourites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../../domain/entities/show.dart';
import '../entities/episode.dart';
import '../entities/season.dart';

abstract class ShowRepository{

  Future<Either<Failure,List<Show>>> getAllShows({required int pageNumber});


  Future<Either<Failure,List<Season>>> getAllShowSeasons({required String showId});

  
  Future<Either<Failure,List<Episode>>> getAllSeasonEpisodes({required String seasonId});


  Future<Either<Failure,List<Show>>> getSearch(SearchParameters parameters);


  Future<Either<Failure,List<Show?>>> getAllFavourites();


  Future<Either<Failure,List<Show?>>> toggleFavourites(ToggleFavouritesParameters parameters);


  Future<Either<Failure,bool>> isFavourites(IsFavouritesParameters parameters);

}