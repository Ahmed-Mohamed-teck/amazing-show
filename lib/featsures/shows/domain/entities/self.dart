
import 'package:equatable/equatable.dart';

class Self extends Equatable{
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }

  @override
  List<Object?> get props => [href];
}