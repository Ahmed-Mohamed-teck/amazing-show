import 'package:amazing_tv/featsures/shows/domain/entities/season.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../repositories/show_repository.dart';

class GetAllShowSeasonsUseCase{
  final ShowRepository repositories;

  GetAllShowSeasonsUseCase(this.repositories);

  Future<Either<Failure,List<Season>>> call({required String showId})async{
    return await repositories.getAllShowSeasons(showId: showId);
  }

}