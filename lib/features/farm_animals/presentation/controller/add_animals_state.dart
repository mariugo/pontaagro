// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';

part 'add_animals_state.g.dart';

@match
enum AddAnimalsStatus { initial, loading, success, error }

class AddAnimalsState extends Equatable {
  final AddAnimalsStatus status;
  List<AnimalsModel> animals = [];

  AddAnimalsState({
    required this.status,
    required this.animals,
  });

  AddAnimalsState.initial()
      : status = AddAnimalsStatus.initial,
        animals = [];

  AddAnimalsState copyWith({
    AddAnimalsStatus? status,
    List<AnimalsModel>? animals,
  }) {
    return AddAnimalsState(
      status: status ?? this.status,
      animals: animals ?? this.animals,
    );
  }

  @override
  List<Object?> get props => [status, animals];
}
