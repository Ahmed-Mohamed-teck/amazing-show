import 'package:amazing_tv/featsures/shows/domain/entities/self.dart';
import 'package:equatable/equatable.dart';

class Links extends Equatable{
  Self? self;
  Self? previousepisode;

  Links({this.self, this.previousepisode});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? Self.fromJson(json['self']) : null;
    previousepisode = json['previousepisode'] != null
        ? Self.fromJson(json['previousepisode'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.toJson();
    }
    if (previousepisode != null) {
      data['previousepisode'] = previousepisode!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [self,previousepisode];
}