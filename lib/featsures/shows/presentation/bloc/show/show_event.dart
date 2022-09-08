

import 'package:equatable/equatable.dart';

abstract class ShowEvent extends Equatable{
  const ShowEvent();

  @override
  List<Object?> get props => [];
}

class GetAllShowsEvent extends ShowEvent{}

class RefreshShowsEvent extends ShowEvent{}

class ToggleFavoriteEvent extends ShowEvent{}