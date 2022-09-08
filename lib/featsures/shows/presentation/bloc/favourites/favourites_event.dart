part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}
class GetAllFavouritesEvent extends FavouritesEvent{


  const GetAllFavouritesEvent();

  @override
  List<Object?> get props => [];
}

class GetToggleFavouritesEvent extends FavouritesEvent{
  final Show show;

  const GetToggleFavouritesEvent({required this.show});

  @override
  List<Object?> get props => [show];
}

class GetIsFavouritesEvent extends FavouritesEvent{
  final Show show;

  const GetIsFavouritesEvent({required this.show});

  @override
  List<Object?> get props => [show];
}