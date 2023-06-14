import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';

part 'add_animals_state.g.dart';

@match
enum AddAnimalsStatus { initial, loading, success, error }

class AddAnimalsState extends Equatable {
  final AddAnimalsStatus status;
  final List<AnimalsModel> animals;

  const AddAnimalsState({
    required this.status,
    required this.animals,
  });

  const AddAnimalsState.initial()
      : status = AddAnimalsStatus.initial,
        animals = const [];

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
