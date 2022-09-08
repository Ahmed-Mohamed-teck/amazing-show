part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}
class GetSearchEvent extends SearchEvent{
  final String quary;

  const GetSearchEvent({required this.quary});

  @override
  List<Object?> get props => [quary];
}

