import 'package:amazing_tv/featsures/shows/domain/entities/image.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/link.dart';
import 'package:amazing_tv/featsures/shows/domain/entities/network.dart';
import 'package:equatable/equatable.dart';

class Season extends Equatable{
  int? id;
  String? url;
  int? number;
  String? name;
  int? episodeOrder;
  String? premiereDate;
  String? endDate;
  Network? network;
  Image? image;
  String? summary;
  Links? lLinks;

  Season(
      {
        this.id,
        this.url,
        this.number,
        this.name,
        this.episodeOrder,
        this.premiereDate,
        this.endDate,
        this.network,
        this.image,
        this.summary,
        this.lLinks
      });

  @override
  List<Object?> get props => [
    id,
    url,
    number,
    name,
    episodeOrder,
    premiereDate,
    endDate,
    network,
    image,
    summary,
    lLinks
  ];
}