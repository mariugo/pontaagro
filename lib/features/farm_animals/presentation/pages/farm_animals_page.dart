import 'package:flutter/material.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';
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
          'Fazenda >> Animais ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: animals.length,
          itemBuilder: (context, index) {
            return AnimalTile(
              canEdit: false,
              animal: animals[index],
              onDelete: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Excluir animal'),
                  content: Text(
                    'Deseja realmente excluir o animal?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Não',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: context.percentWidth(0.010),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Sim',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error)),
                    ),
                  ],
                ),
              ),
            );
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
