import 'package:mobile_security/bhushan/features/dynamic_form/data/models/dropdown_item_entity.dart';

part 'dropdown_model.g.dart';

class DropdownModel extends DropdownItemEntity {
  const DropdownModel({super.label, super.value});

  factory DropdownModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownModelFromJson(json);
  Map<String, dynamic> toJson() => _$DropdownModelToJson(this);
}
