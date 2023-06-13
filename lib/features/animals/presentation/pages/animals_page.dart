import 'package:flutter/material.dart';
import 'package:pontaagro/features/animals/data/models/animals_model.dart';
import 'package:pontaagro/features/animals/presentation/widgets/animal_tile.dart';

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
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
