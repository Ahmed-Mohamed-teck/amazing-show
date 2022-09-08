import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../entities/show.dart';
import '../repositories/show_repository.dart';

class GetAllFavouritesUseCase {
  final ShowRepository repositories;

  GetAllFavouritesUseCase(this.repositories);

  Future<Either<Failure, List<Show?>>> call() async {
    return await repositories.getAllFavourites();
  }
}
