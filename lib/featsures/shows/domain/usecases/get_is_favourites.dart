import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/fialures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/show.dart';
import '../repositories/show_repository.dart';

class GetIsFavouritesUseCase extends BaseUseCase<bool,IsFavouritesParameters>  {
  final ShowRepository repositories;

  GetIsFavouritesUseCase(this.repositories);

  @override
  Future<Either<Failure, bool>> call(IsFavouritesParameters parameters) async {
    return await repositories.isFavourites(parameters);
  }
}
class IsFavouritesParameters extends Equatable {
  final Show favProduct;

  const IsFavouritesParameters({required this.favProduct});

  @override
  List<Object> get props => [favProduct];
}