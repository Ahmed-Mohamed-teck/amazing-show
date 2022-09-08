part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearchState extends SearchState {
  @override
  List<Object?> get props => [];
}

class LoadedSearchState extends SearchState {
  final List<Show> shows;

   LoadedSearchState({required this.shows,});

  @override
  List<Object?> get props => [shows];
}

class ErrorSearchState extends SearchState {
  final String message;

  const ErrorSearchState({required this.message});

  @override
  List<Object?> get props => [message];
}
