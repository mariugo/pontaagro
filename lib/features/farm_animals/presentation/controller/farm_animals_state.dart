import 'package:match/match.dart';
import 'package:equatable/equatable.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';

part 'farm_animals_state.g.dart';

@match
enum FarmAnimalsStatus { initial, loading, success, error }

class FarmAnimalsState extends Equatable {
  final FarmAnimalsStatus status;
  final List<AnimalsModel> animals;

  const FarmAnimalsState({
    required this.status,
    required this.animals,
  });

  const FarmAnimalsState.initial()
      : status = FarmAnimalsStatus.initial,
        animals = const [];

  FarmAnimalsState copyWith({
    FarmAnimalsStatus? status,
    List<AnimalsModel>? animals,
  }) {
    return FarmAnimalsState(
      status: status ?? this.status,
      animals: animals ?? this.animals,
    );
  }

  @override
  List<Object?> get props => [status, animals];
}
