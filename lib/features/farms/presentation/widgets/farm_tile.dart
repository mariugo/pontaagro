import 'package:flutter/material.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';

class FarmTile extends StatelessWidget {
  final FarmsModel farm;
  final Future<void> Function() onDelete;
  final Future<void> Function() onEdit;

  const FarmTile({
    required this.farm,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              farm.name,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: Text(
              'Animais: ${farm.quantity}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            trailing: SizedBox(
              width: 190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onEdit,
                    child: const Text('Editar'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: onDelete,
                    child: Text(
                      'Excluir',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Theme.of(context).colorScheme.error),
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
