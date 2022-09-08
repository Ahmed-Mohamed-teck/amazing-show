import 'package:amazing_tv/featsures/shows/domain/entities/episode.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../repositories/show_repository.dart';

class GetAllSeasonEpisodesUseCase{
  final ShowRepository repositories;

  GetAllSeasonEpisodesUseCase(this.repositories);

  Future<Either<Failure,List<Episode>>> call({required String seasonId})async{
    return await repositories.getAllSeasonEpisodes(seasonId: seasonId);
  }

}