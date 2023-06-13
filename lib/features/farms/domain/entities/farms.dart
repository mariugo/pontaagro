import 'package:equatable/equatable.dart';

class Farms extends Equatable {
  final int? id;
  final String name;
  final int quantity;

  const Farms({
    this.id,
    required this.name,
    this.quantity = 0,
  });

  @override
  List<Object?> get props => [id, name, quantity];
}