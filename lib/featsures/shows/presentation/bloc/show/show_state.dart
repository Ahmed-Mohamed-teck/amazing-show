part of 'show_bloc.dart';

@immutable
abstract class ShowState extends Equatable{
  const ShowState();
  @override
  List<Object?> get props => [];
}

class ShowInitial extends ShowState {}

class LoadingShowsState extends ShowState{}


class ToggleFavoriteState extends ShowState{}

class LoadedShowsState extends ShowState{
  final List<Show> shows;

  const LoadedShowsState({required this.shows});


  @override
  List<Object?> get props => [shows];
}

class ErrorShowsState extends ShowState{
  final String message;

  const ErrorShowsState({required this.message});

  @override
  List<Object?> get props => [message];
}
