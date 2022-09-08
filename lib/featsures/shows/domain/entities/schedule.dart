import 'package:equatable/equatable.dart';

class Schedule extends Equatable{
  String? time;
  List<String>? days;

  Schedule({this.time, this.days});

  Schedule.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    days = json['days'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['days'] = days;
    return data;
  }

  @override
  List<Object?> get props => [time,days];
}