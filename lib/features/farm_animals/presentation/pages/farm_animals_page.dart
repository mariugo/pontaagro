import 'package:flutter/material.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/presentation/widgets/animal_tile.dart';

class FarmAnimalsPage extends StatefulWidget {
  const FarmAnimalsPage({super.key});

  @override
  State<FarmAnimalsPage> createState() => _FarmAnimalsPageState();
}

class _FarmAnimalsPageState extends State<FarmAnimalsPage> {
  final animals = [
    const AnimalsModel(
      name: 'Vaca',
      tag: '123456789',
      farmId: 1,
    ),
    const AnimalsModel(
      name: 'Vaca',
      tag: '123456789',
      farmId: 1,
    ),
    const AnimalsModel(
      name: 'Vaca',
      tag: '123456789',
      farmId: 1,
    ),
    const AnimalsModel(
      name: 'Vaca',
      tag: '123456789',
      farmId: 1,
    ),
    const AnimalsModel(
      name: 'Vaca',
      tag: '123456789',
      farmId: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          'PontAgro',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: animals.length,
          itemBuilder: (context, index) {
            return AnimalTile(animal: animals[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Animal'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
