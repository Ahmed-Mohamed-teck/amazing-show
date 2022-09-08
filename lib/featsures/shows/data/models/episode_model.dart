import 'package:amazing_tv/featsures/shows/domain/entities/episode.dart';

import '../../domain/entities/image.dart';
import '../../domain/entities/link.dart';
import '../../domain/entities/rating.dart';

class EpisodeModel extends Episode {
  EpisodeModel({
    int? id,
    String? url,
    String? name,
    int? season,
    int? number,
    String? type,
    String? airdate,
    String? airtime,
    String? airstamp,
    int? runtime,
    Rating? rating,
    Image? image,
    String? summary,
    Links? lLinks,
  }) : super(
            id: id,
            url: url,
            name: name,
            season: season,
            number: number,
            type: type,
            airdate: airdate,
            airtime: airtime,
            airstamp: airstamp,
            runtime: runtime,
            rating: rating,
            image: image,
            summary: summary,
            lLinks: lLinks);

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    season = json['season'];
    number = json['number'];
    type = json['type'];
    airdate = json['airdate'];
    airtime = json['airtime'];
    airstamp = json['airstamp'];
    runtime = json['runtime'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['season'] = season;
    data['number'] = number;
    data['type'] = type;
    data['airdate'] = airdate;
    data['airtime'] = airtime;
    data['airstamp'] = airstamp;
    data['runtime'] = runtime;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }
}
