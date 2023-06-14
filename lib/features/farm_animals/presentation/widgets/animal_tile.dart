import 'package:flutter/material.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';

class AnimalTile extends StatelessWidget {
  final AnimalsModel animal;

  const AnimalTile({
    required this.animal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              animal.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              'TAG: ${animal.tag}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: SizedBox(
              width: 190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Editar'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Excluir',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
