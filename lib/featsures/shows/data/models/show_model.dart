import '../../domain/entities/external.dart';
import '../../domain/entities/image.dart';
import '../../domain/entities/link.dart';
import '../../domain/entities/network.dart';
import '../../domain/entities/rating.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/entities/show.dart';

class ShowModel extends Show {
  ShowModel({
    int? id,
    String? url,
    String? name,
    String? type,
    String? language,
    List<String>? genres,
    String? status,
    int? runtime,
    int? averageRuntime,
    String? premiered,
    String? ended,
    String? officialSite,
    Schedule? schedule,
    Rating? rating,
    int? weight,
    Network? network,
    // Null? webChannel,
    // Null? dvdCountry,
    Externals? externals,
    Image? image,
    String? summary,
    int? updated,
    Links? lLinks,
  }) : super(
            id: id,
            url: url,
            name: name,
            type: type,
            language: language,
            genres: genres,
            status: status,
            runtime: runtime,
            averageRuntime: averageRuntime,
            premiered: premiered,
            ended: ended,
            officialSite: officialSite,
            schedule: schedule,
            rating: rating,
            weight: weight,
            network: network,
            externals: externals,
            image: image,
            summary: summary,
            updated: updated,
            lLinks: lLinks);

  ShowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
    language = json['language'];
    genres = json['genres'].cast<String>();
    status = json['status'];
    runtime = json['runtime'];
    averageRuntime = json['averageRuntime'];
    premiered = json['premiered'];
    ended = json['ended'];
    officialSite = json['officialSite'];
    schedule = json['schedule'] != null
        ? Schedule.fromJson(json['schedule'])
        : null;
    rating =
    json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    weight = json['weight'];
    network =
    json['network'] != null ? Network.fromJson(json['network']) : null;
    // webChannel = json['webChannel'];
    // dvdCountry = json['dvdCountry'];
    externals = json['externals'] != null
        ? Externals.fromJson(json['externals'])
        : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    updated = json['updated'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['type'] = type;
    data['language'] = language;
    data['genres'] = genres;
    data['status'] = status;
    data['runtime'] = runtime;
    data['averageRuntime'] = averageRuntime;
    data['premiered'] = premiered;
    data['ended'] = ended;
    data['officialSite'] = officialSite;
    if (schedule != null) {
      data['schedule'] = schedule!.toJson();
    }
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['weight'] = weight;
    if (network != null) {
      data['network'] = network!.toJson();
    }
    // data['webChannel'] = this.webChannel;
    // data['dvdCountry'] = this.dvdCountry;
    if (externals != null) {
      data['externals'] = externals!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;
    data['updated'] = updated;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }


  Map<String, dynamic> toJsonShow(Show favProduct) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = favProduct.id;
    data['url'] = favProduct.url;
    data['name'] = favProduct.name;
    data['type'] = favProduct.type;
    data['language'] = favProduct.language;
    data['genres'] = favProduct.genres;
    data['status'] = favProduct.status;
    data['runtime'] = favProduct.runtime;
    data['averageRuntime'] = favProduct.averageRuntime;
    data['premiered'] = favProduct.premiered;
    data['ended'] = favProduct.ended;
    data['officialSite'] = favProduct.officialSite;
    if (favProduct.schedule != null) {
      data['schedule'] = favProduct.schedule!.toJson();
    }
    if (favProduct.rating != null) {
      data['rating'] = favProduct.rating!.toJson();
    }
    data['weight'] = favProduct.weight;
    if (favProduct.network != null) {
      data['network'] = favProduct.network!.toJson();
    }
    // data['webChannel'] = this.webChannel;
    // data['dvdCountry'] = this.dvdCountry;
    if (favProduct.externals != null) {
      data['externals'] = favProduct.externals!.toJson();
    }
    if (favProduct.image != null) {
      data['image'] = favProduct.image!.toJson();
    }
    data['summary'] = favProduct.summary;
    data['updated'] = favProduct.updated;
    if (favProduct.lLinks != null) {
      data['_links'] = favProduct.lLinks!.toJson();
    }
    return data;
  }

}

