import 'package:amazing_tv/featsures/shows/domain/entities/season.dart';

import '../../domain/entities/image.dart';
import '../../domain/entities/link.dart';
import '../../domain/entities/network.dart';

class SeasonModel extends Season {
  SeasonModel({
    int? id,
    String? url,
    int? number,
    String? name,
    int? episodeOrder,
    String? premiereDate,
    String? endDate,
    Network? network,
    Image? image,
    String? summary,
    Links? lLinks,
  }) : super(
          id: id,
          url: url,
          number: number,
          name: name,
          episodeOrder: episodeOrder,
          premiereDate: premiereDate,
          endDate: endDate,
          network: network,
          image: image,
          summary: summary,
          lLinks: lLinks,
        );

  SeasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    number = json['number'];
    name = json['name'];
    episodeOrder = json['episodeOrder'];
    premiereDate = json['premiereDate'];
    endDate = json['endDate'];
    network =
        json['network'] != null ? Network.fromJson(json['network']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['number'] = number;
    data['name'] = name;
    data['episodeOrder'] = episodeOrder;
    data['premiereDate'] = premiereDate;
    data['endDate'] = endDate;
    if (network != null) {
      data['network'] = network!.toJson();
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
