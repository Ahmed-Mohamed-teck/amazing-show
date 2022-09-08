
import 'package:equatable/equatable.dart';

abstract class SeasonEvent extends Equatable{
  const SeasonEvent();

  @override
  List<Object?> get props => [];
}

class GetAllShowSeasonsEvent extends SeasonEvent{
  final String showId;

  const GetAllShowSeasonsEvent(this.showId);

  @override
  List<Object?> get props => [showId];

}




