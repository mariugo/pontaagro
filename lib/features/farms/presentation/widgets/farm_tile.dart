import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';
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
      onTap: () async {
        await Navigator.of(context).pushNamed(
          '/farm-animals',
          arguments: {
            'farm': farm,
          },
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: FaIcon(
            FontAwesomeIcons.tractor,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        title: Text(
          farm.name,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        subtitle: Text(
          'Animais: ${farm.quantity}',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        trailing: SizedBox(
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
        ),
      ),
    );
  }
}
