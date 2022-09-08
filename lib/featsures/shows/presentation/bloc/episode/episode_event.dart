
import 'package:equatable/equatable.dart';

abstract class EpisodeEvent extends Equatable{
  const EpisodeEvent();

  @override
  List<Object?> get props => [];
}



class GetAllSeasonEpisodesEvent extends EpisodeEvent{
  final String seasonId;

  const GetAllSeasonEpisodesEvent({required this.seasonId});

  @override
  List<Object?> get props => [seasonId];

}


// class GetSingleEpisode extends EpisodeEvent{
//   final String episodeId;
//
//   const GetSingleEpisode({required this.episodeId});
//
//   @override
//   List<Object?> get props => [episodeId];
//
// }
