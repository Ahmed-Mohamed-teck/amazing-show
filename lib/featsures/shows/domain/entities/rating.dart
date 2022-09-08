import 'package:equatable/equatable.dart';

class Rating extends Equatable{
  double? average;

  Rating({this.average});

  Rating.fromJson(Map<String, dynamic> json) {
    average = double.tryParse(json['average'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = average;
    return data;
  }

  @override
  List<Object?> get props => [average];
}