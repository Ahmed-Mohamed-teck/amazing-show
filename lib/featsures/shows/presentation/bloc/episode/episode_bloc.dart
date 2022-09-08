
import 'package:amazing_tv/featsures/shows/domain/entities/episode.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/episode/episode_event.dart';
import 'package:amazing_tv/featsures/shows/presentation/bloc/episode/episode_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/fialures.dart';
import '../../../domain/usecases/get_all_season_episodes.dart';


class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetAllSeasonEpisodesUseCase getAllSeasonEpisodesUseCase;

  EpisodeBloc({required this.getAllSeasonEpisodesUseCase}) : super(EpisodeInitial()) {
    on<EpisodeEvent>((event, emit) async{
      if(event is GetAllSeasonEpisodesEvent){
        emit(LoadingSeasonEpisodesState());
        final failureOrEpisodes = await getAllSeasonEpisodesUseCase.call(seasonId: event.seasonId);
        emit(_mapFailureOrSeasonToState(failureOrEpisodes));
      }
      // else if(event is GetSingleEpisode){
      //   emit(LoadingSeasonEpisodesState());
      //   final failureOrEpisodes = await getAllSeasonEpisodesUseCase.call(seasonId: event.seasonId);
      //   emit(_mapFailureOrSeasonToState(failureOrEpisodes));
      // }
    });
  }

  EpisodeState _mapFailureOrSeasonToState(Either<Failure, List<Episode>> either) {
    return either.fold(
            (failure) => ErrorSeasonEpisodesState(message: _mapFailureToMessage(failure)),
            (episodes) => LoadedSeasonEpisodesState(episodes: episodes));
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
