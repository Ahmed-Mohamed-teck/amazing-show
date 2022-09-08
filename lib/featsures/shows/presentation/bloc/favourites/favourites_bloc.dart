import 'package:amazing_tv/featsures/shows/domain/usecases/get_all_favourites.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_is_favourites.dart';
import 'package:amazing_tv/featsures/shows/domain/usecases/get_toggle_favourites.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/fialures.dart';
import '../../../domain/entities/show.dart';

part 'favourites_event.dart';

part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetAllFavouritesUseCase getAllFavouritesUseCase;
  final GetToggleFavouritesUseCase getToggleFavouritesUseCase;
  final GetIsFavouritesUseCase getIsFavouritesUseCase;
  List<Show?> favList =[];

  FavouritesBloc(
      {required this.getAllFavouritesUseCase,
      required this.getToggleFavouritesUseCase,
      required this.getIsFavouritesUseCase})
      : super(FavouritesInitial()) {
    on<GetAllFavouritesEvent>((event, emit) async {
      emit(LoadingGetAllFavouritesState());
      final failureOrPosts = await getAllFavouritesUseCase();

      failureOrPosts.fold(
          (failure) => emit(ErrorGetAllFavouritesState(
              message: _mapFailureToMessage(failure))),
          (shows) {
            favList =shows;
            emit(LoadedGetAllFavouritesState(show: shows));
          });
    });

    on<GetToggleFavouritesEvent>((event, emit) async {
      emit(LoadingGetToggleFavouritesState());
      final failureOrPosts = await getToggleFavouritesUseCase(
          ToggleFavouritesParameters(favProduct: event.show));

      failureOrPosts.fold(
          (failure) => emit(ErrorGetToggleFavouritesState(
              message: _mapFailureToMessage(failure))),
          (shows) {
            favList =shows;
            emit( LoadedGetToggleFavouritesState(show: shows));
          });
    });
    on<GetIsFavouritesEvent>((event, emit) async {
      emit(LoadingGetToggleFavouritesState());
      final failureOrPosts = await getIsFavouritesUseCase(
          IsFavouritesParameters(favProduct: event.show));

      failureOrPosts.fold(
          (failure) => emit(ErrorGetIsFavouritesState(
              message: _mapFailureToMessage(failure))),
          (isFav) => emit(LoadedGetIsFavouritesState(isFav: isFav)));
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
