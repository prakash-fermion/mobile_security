import 'package:equatable/equatable.dart';

class DropdownEntity extends Equatable {
  final String? label;
  final String? code;

  const DropdownEntity({this.label, this.code});

  @override
  List<Object?> get props => [label, code];
}

