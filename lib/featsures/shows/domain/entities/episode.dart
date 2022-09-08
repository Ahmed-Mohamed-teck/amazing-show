import 'package:amazing_tv/featsures/shows/domain/entities/image.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/link.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/rating.dart';
import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  int? id;
  String? url;
  String? name;
  int? season;
  int? number;
  String? type;
  String? airdate;
  String? airtime;
  String? airstamp;
  int? runtime;
  Rating? rating;
  Image? image;
  String? summary;
  Links? lLinks;

  Episode({
    this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.type,
    this.airdate,
    this.airtime,
    this.airstamp,
    this.runtime,
    this.rating,
    this.image,
    this.summary,
    this.lLinks,
  });

  @override
  List<Object?> get props => [
    id,
    url,
    name,
    season,
    number,
    type,
    airdate,
    airtime,
    airstamp,
    runtime,
    rating,
    image,
    summary,
    lLinks,
  ];
}
