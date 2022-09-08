import 'package:equatable/equatable.dart';

class Country extends Equatable{
  String? name;
  String? code;
  String? timezone;

  Country({this.name, this.code, this.timezone});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['timezone'] = timezone;
    return data;
  }

  @override
  List<Object?> get props => [name,code,timezone];
}