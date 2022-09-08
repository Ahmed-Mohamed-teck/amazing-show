import 'package:amazing_tv/core/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/fialures.dart';
import '../entities/show.dart';
import '../repositories/show_repository.dart';

class GetToggleFavouritesUseCase extends BaseUseCase<List<Show?>,ToggleFavouritesParameters>  {
  final ShowRepository repositories;

  GetToggleFavouritesUseCase(this.repositories);

  Future<Either<Failure, List<Show?>>> call(ToggleFavouritesParameters parameters) async {
    return await repositories.toggleFavourites(parameters);
  }
}
class ToggleFavouritesParameters extends Equatable {
  final Show favProduct;

  const ToggleFavouritesParameters({required this.favProduct});

  @override
  List<Object> get props => [favProduct];
}