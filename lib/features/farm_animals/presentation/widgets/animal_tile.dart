import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';

class AnimalTile extends StatelessWidget {
  final AnimalsModel animal;
  final Future<void> Function() onDelete;
  final void Function()? onEdit;
  final bool canEdit;

  const AnimalTile({
    required this.onDelete,
    required this.animal,
    required this.canEdit,
    this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: FaIcon(
          FontAwesomeIcons.cow,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      title: Text(
        animal.name,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      subtitle: Text(
        'TAG: ${animal.tag}',
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
      trailing: canEdit
          ? SizedBox(
              width: context.percentWidth(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onEdit,
                    child: Text(
                      'Editar',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
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
            )
          : TextButton(
              onPressed: onDelete,
              child: Text(
                'Excluir',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
    );
  }
}
