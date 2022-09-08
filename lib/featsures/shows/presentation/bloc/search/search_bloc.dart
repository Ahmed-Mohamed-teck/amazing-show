import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../core/error/fialures.dart';
import '../../../domain/entities/show.dart';
import '../../../domain/usecases/get_search_seasons.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchUseCase getSearchUseCase;
  SearchBloc({required this.getSearchUseCase}) : super(SearchInitial()) {
    on<GetSearchEvent>((event, emit) async{
        emit(LoadingSearchState());
        final failureOrPosts = await getSearchUseCase(SearchParameters(quary: event.quary));
        failureOrPosts.fold(
                (failure) => emit(ErrorSearchState(
                message: _mapFailureToMessage(failure))),
                (shows) => emit(LoadedSearchState(shows:  shows)));

    });
  }



  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'please try again later';
      case EmptyCacheFailure:
        return 'no data';
      case OfflineFailure:
        return 'please check your internet connection';
      default:
        return 'Unexpected error please try again later .';
    }
  }
}
