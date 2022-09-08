
import 'package:equatable/equatable.dart';

import '../../../domain/entities/episode.dart';

abstract class EpisodeState extends Equatable{
  const EpisodeState();

  @override
  List<Object?> get props => [];
}

class EpisodeInitial extends EpisodeState {}


class LoadingSeasonEpisodesState extends EpisodeState{}

class LoadedSeasonEpisodesState extends EpisodeState{
  final List<Episode> episodes;

  const LoadedSeasonEpisodesState({required this.episodes});


  @override
  List<Object?> get props => [episodes];
}

class ErrorSeasonEpisodesState extends EpisodeState{
  final String message;

  const ErrorSeasonEpisodesState({required this.message});

  @override
  List<Object?> get props => [message];
}
