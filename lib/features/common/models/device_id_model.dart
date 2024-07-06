import 'package:json_annotation/json_annotation.dart';

part 'device_id_model.g.dart';

@JsonSerializable()
class DeviceIdModel {

  String? deviceId;

  Map<String, dynamic> toJson() => _$DeviceIdModelToJson(this);

}