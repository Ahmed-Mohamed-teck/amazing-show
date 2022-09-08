import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../entities/show.dart';
import '../repositories/show_repository.dart';

class GetAllShowsUseCase{
  final ShowRepository repositories;

  GetAllShowsUseCase(this.repositories);

  Future<Either<Failure,List<Show>>> call({required int pageNumber})async{
    return await repositories.getAllShows(pageNumber: pageNumber);
  }

}