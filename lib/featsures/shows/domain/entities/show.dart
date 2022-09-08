import 'package:amazing_tv/featsures/shows/domain/entities/external.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/image.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/link.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/network.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/rating.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/schedule.dart';
import 'package:equatable/equatable.dart';

class Show extends Equatable {
  int? id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  String? status;
  int? runtime;
  int? averageRuntime;
  String? premiered;
  String? ended;
  String? officialSite;
  Schedule? schedule;
  Rating? rating;
  int? weight;
  Network? network;
  // Null? webChannel;
  // Null? dvdCountry;
  Externals? externals;
  Image? image;
  String? summary;
  int? updated;
  Links? lLinks;

  Show(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.language,
      this.genres,
      this.status,
      this.runtime,
      this.averageRuntime,
      this.premiered,
      this.ended,
      this.officialSite,
      this.schedule,
      this.rating,
      this.weight,
      this.network,
      // this.webChannel,
      // this.dvdCountry,
      this.externals,
      this.image,
      this.summary,
      this.updated,
      this.lLinks});

  @override
  List<Object?> get props => [
        id,
        url,
        name,
        type,
        language,
        genres,
        status,
        runtime,
        averageRuntime,
        premiered,
        ended,
        officialSite,
        schedule,
        rating,
        weight,
        network,
        // webChannel,
        // dvdCountry,
        externals,
        image,
        summary,
        updated,
        lLinks
      ];
}
