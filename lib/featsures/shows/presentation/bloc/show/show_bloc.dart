
import 'package:amazing_tv/featsures/shows/domain/usecases/get_all_shows.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/show/show_event.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/fialures.dart';
import '../../../domain/entities/show.dart';

part 'show_state.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  final GetAllShowsUseCase getAllShowsUseCase;
  final int _pageNumber =0;

  ShowBloc({required this.getAllShowsUseCase}) : super(ShowInitial()) {
    on<ShowEvent>((event, emit) async{
      if (event is GetAllShowsEvent ||event is RefreshShowsEvent) {
        emit(LoadingShowsState());
        final failureOrPosts = await getAllShowsUseCase.call(pageNumber: _pageNumber);
        emit(_mapFailureOrPostToState(failureOrPosts));
      }else if (event is ToggleFavoriteState){
        emit(ToggleFavoriteState());
      }
    });
  }

  ShowState _mapFailureOrPostToState(Either<Failure, List<Show>> either) {
    return either.fold(
            (failure) => ErrorShowsState(message: _mapFailureToMessage(failure)),
            (shows) => LoadedShowsState(shows: shows));
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
