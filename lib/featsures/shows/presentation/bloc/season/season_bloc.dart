
import 'package:amazing_tv/featsures/shows/domain/entities/season.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/season/season_event.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/season/season_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/fialures.dart';
import '../../../domain/usecases/get_all_show_seasons.dart';



class SeasonBloc extends Bloc<SeasonEvent, SeasonState> {
  final GetAllShowSeasonsUseCase getAllShowSeasonsUseCase;



  SeasonBloc({required this.getAllShowSeasonsUseCase}) : super(SeasonInitial()) {
    on<SeasonEvent>((event, emit) async{
      if (event is GetAllShowSeasonsEvent) {
        emit(LoadingShowSeasonState());
        final failureOrSeasons = await getAllShowSeasonsUseCase.call(showId: event.showId);
        emit(_mapFailureOrSeasonToState(failureOrSeasons));
      }
    });
  }

  SeasonState _mapFailureOrSeasonToState(Either<Failure, List<Season>> either) {
    return either.fold(
            (failure) => ErrorShowSeasonState(message: _mapFailureToMessage(failure)),
            (seasons) => LoadedShowSeasonState(seasons: seasons));
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
