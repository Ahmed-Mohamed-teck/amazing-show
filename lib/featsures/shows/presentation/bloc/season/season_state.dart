
import 'package:amazing_tv/featsures/shows/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

abstract class SeasonState extends Equatable{
  const SeasonState();
  @override
  List<Object?> get props => [];
}

class SeasonInitial extends SeasonState {}


/// seasons states
class LoadingShowSeasonState extends SeasonState{}

class LoadedShowSeasonState extends SeasonState{
  final List<Season> seasons;

  const LoadedShowSeasonState({required this.seasons});


  @override
  List<Object?> get props => [seasons];
}

class ErrorShowSeasonState extends SeasonState{
  final String message;

  const ErrorShowSeasonState({required this.message});

  @override
  List<Object?> get props => [message];
}



