import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/fialures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/show.dart';
import '../repositories/show_repository.dart';

class GetSearchUseCase extends BaseUseCase<List<Show>, SearchParameters> {
  final ShowRepository repositories;

  GetSearchUseCase(this.repositories);

  Future<Either<Failure, List<Show>>> call(SearchParameters parameters) async {
    return await repositories.getSearch(parameters);
  }
}

class SearchParameters extends Equatable {
  final String quary;

  const SearchParameters({required this.quary});

  @override
  List<Object> get props => [quary];
}
