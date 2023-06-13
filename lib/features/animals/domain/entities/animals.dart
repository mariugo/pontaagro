import 'package:equatable/equatable.dart';

class Animals extends Equatable {
  final int? id;
  final int farmId;
  final String name;
  final String tag;

  const Animals({
    this.id,
    required this.farmId,
    required this.name,
    required this.tag,
  });

  @override
  List<Object?> get props => [id, farmId, name, tag];
}
