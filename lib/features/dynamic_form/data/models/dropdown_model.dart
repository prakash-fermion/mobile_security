import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_security/features/dynamic_form/domain/entities/dropdown_item_entity.dart';

part 'dropdown_model.g.dart';

@JsonSerializable()
class DropdownModel extends DropdownItemEntity {
  const DropdownModel({super.label, super.value});

  factory DropdownModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownModelFromJson(json);
  Map<String, dynamic> toJson() => _$DropdownModelToJson(this);
}
