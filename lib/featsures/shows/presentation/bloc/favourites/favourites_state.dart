part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class FavouritesInitial extends FavouritesState {
  @override
  List<Object> get props => [];
}


class LoadingGetAllFavouritesState extends FavouritesState{
  @override
  List<Object?> get props => [];
}

class LoadedGetAllFavouritesState extends FavouritesState{
  final List<Show?> show;

  const LoadedGetAllFavouritesState({required this.show});


  @override
  List<Object?> get props => [show];
}

class ErrorGetAllFavouritesState extends FavouritesState{
  final String message;

  const ErrorGetAllFavouritesState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoadingGetToggleFavouritesState extends FavouritesState{
  @override
  List<Object?> get props => [];
}

class LoadedGetToggleFavouritesState extends FavouritesState{
  final List<Show?> show;

  const LoadedGetToggleFavouritesState({required this.show});


  @override
  List<Object?> get props => [show];
}

class ErrorGetToggleFavouritesState extends FavouritesState{
  final String message;

  const ErrorGetToggleFavouritesState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoadingGetIsFavouritesState extends FavouritesState{
  @override
  List<Object?> get props => [];
}

class LoadedGetIsFavouritesState extends FavouritesState{

  final bool isFav;
  const LoadedGetIsFavouritesState({required this.isFav});


  @override
  List<Object?> get props => [isFav];
}

class ErrorGetIsFavouritesState extends FavouritesState{
  final String message;

  const ErrorGetIsFavouritesState({required this.message});

  @override
  List<Object?> get props => [message];
}