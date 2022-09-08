import 'package:equatable/equatable.dart';

class Externals extends Equatable{
  int? tvrage;
  int? thetvdb;
  String? imdb;

  Externals({this.tvrage, this.thetvdb, this.imdb});

  Externals.fromJson(Map<String, dynamic> json) {
    tvrage = json['tvrage'];
    thetvdb = json['thetvdb'];
    imdb = json['imdb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tvrage'] = tvrage;
    data['thetvdb'] = thetvdb;
    data['imdb'] = imdb;
    return data;
  }

  @override
  List<Object?> get props => [tvrage,thetvdb,imdb];
}
