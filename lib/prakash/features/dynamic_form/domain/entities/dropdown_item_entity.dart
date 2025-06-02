import 'package:equatable/equatable.dart';

class DropdownItemEntity extends Equatable {
  final String? label;
  final String? value;

  const DropdownItemEntity({this.label, this.value});

  @override
  List<Object?> get props => [label, value];
}
