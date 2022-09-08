import 'package:amazing_tv/core/error/exception.dart';
import 'package:amazing_tv/core/network/dio_helper.dart';
import 'package:amazing_tv/featsures/shows/data/models/episode_model.dart';
import 'package:amazing_tv/featsures/shows/data/models/show_model.dart';

import '../../domain/usecases/get_search_seasons.dart';
import '../models/season_model.dart';

abstract class ShowRemoteDataSource{


  /// get all the show from api it return 250 shows per page
  Future<List<ShowModel>> getAllShows({required int pageNumber});


  /// get all seasons for specific show
  Future<List<SeasonModel>> getAllShowSeasons({required String id});


  /// get all episodes for single season
  Future<List<EpisodeModel>> getAllSeasonEpisodes({required String seasonId});


  Future<List<ShowModel>> getSearch(SearchParameters parameters);

}

class ShowRemoteDataSourceImpl implements ShowRemoteDataSource{

  @override
  Future<List<ShowModel>> getAllShows({required int pageNumber}) async{
    var response = await DioHelper.getData(url: '/shows?page=$pageNumber');
    if (response.statusCode == 200) {
      List jsonResponse = response.data;
      return jsonResponse.map((e) => ShowModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeasonModel>> getAllShowSeasons({required String id}) async{
    var response = await DioHelper.getData(url: '/shows/$id/seasons');
    if (response.statusCode == 200) {
      List jsonResponse = response.data;
      return jsonResponse.map((e) => SeasonModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EpisodeModel>> getAllSeasonEpisodes({required String seasonId}) async{
    var response = await DioHelper.getData(url: '/seasons/$seasonId/episodes');
    if (response.statusCode == 200) {
      List jsonResponse = response.data;
      return jsonResponse.map((e) => EpisodeModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ShowModel>> getSearch(SearchParameters parameters) async{
    var response = await DioHelper.getData(url: '/search/shows?q=${parameters.quary}');
    if (response.statusCode == 200) {
      List jsonResponse = response.data;
      // return jsonResponse.map((e) => ShowModel.fromJson(e['show'])).toList();
      print('------------------------');

      return List<ShowModel>.from((response.data as List)
          .map((e) => ShowModel.fromJson(e['show'])));
    } else {
      throw ServerException();
    }
  }




}