import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';
import 'package:pontaagro/features/base_state.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_state.dart';
import 'package:pontaagro/features/farm_animals/presentation/widgets/animal_form.dart';
import 'package:pontaagro/features/farm_animals/presentation/widgets/animal_tile.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';

class AddAnimalPage extends StatefulWidget {
  final FarmsModel farm;

  const AddAnimalPage({
    required this.farm,
    super.key,
  });

  @override
  State<AddAnimalPage> createState() => _AddAnimalPageState();
}

class _AddAnimalPageState
    extends BaseState<AddAnimalPage, AddAnimalsController> {
  final formKey = GlobalKey<FormState>();
  final editFormKey = GlobalKey<FormState>();
  final animalNameController = TextEditingController();
  final tagController = TextEditingController();

  @override
  void dispose() {
    animalNameController.dispose();
    tagController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAnimalsController, AddAnimalsState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError('Erro ao salvar animais');
            });
      },
      buildWhen: (previous, current) => current.status.matchAny(
        any: () => false,
        initial: () => true,
        success: () => true,
      ),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              '${widget.farm.name} >> Adicionar Animal',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  AnimalForm(
                    canCancel: true,
                    formKey: formKey,
                    animalNameController: animalNameController,
                    tagController: tagController,
                    onSave: () async {
                      if (formKey.currentState!.validate()) {
                        controller.addAnimalToList(
                          AnimalsModel(
                            name: animalNameController.text,
                            tag: tagController.text,
                            farmId: widget.farm.id!,
                          ),
                        );
                        animalNameController.clear();
                        tagController.clear();
                      }
                    },
                  ),
                  SizedBox(
                    height: context.percentHeight(0.02),
                  ),
                  state.animals.isEmpty
                      ? const SizedBox()
                      : Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            itemCount: state.animals.length,
                            itemBuilder: (context, index) {
                              return AnimalTile(
                                canEdit: true,
                                animal: state.animals[index],
                                onDelete: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Excluir animal'),
                                    content: Text(
                                      'Deseja realmente excluir o animal?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'Não',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.percentWidth(0.010),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.removeAnimalFromList(
                                              state.animals[index]);

                                          Navigator.pop(context);
                                        },
                                        child: Text('Sim',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error)),
                                      ),
                                    ],
                                  ),
                                ),
                                onEdit: () {
                                  animalNameController.text =
                                      state.animals[index].name;
                                  tagController.text = state.animals[index].tag;
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Editar animal'),
                                      content: SizedBox(
                                        //width: double.infinity,
                                        height: context.percentHeight(0.28),
                                        child: AnimalForm(
                                          canCancel: false,
                                          formKey: editFormKey,
                                          animalNameController:
                                              animalNameController,
                                          tagController: tagController,
                                          onSave: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              controller
                                                  .updateAnimalFromList(
                                                    AnimalsModel(
                                                      name: animalNameController
                                                          .text,
                                                      tag: tagController.text,
                                                      farmId: widget.farm.id!,
                                                    ),
                                                  )
                                                  .then((_) => {
                                                        animalNameController
                                                            .clear(),
                                                        tagController.clear(),
                                                        Navigator.pop(context),
                                                      });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: 'clear_all',
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Limpar tudo'),
                    content: Text(
                      'Deseja realmente excluir todos os animais?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Não',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: context.percentWidth(0.010),
                      ),
                      TextButton(
                        onPressed: () {
                          state.animals.clear();
                          Navigator.pop(context);
                        },
                        child: Text('Sim',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.error)),
                      ),
                    ],
                  ),
                ),
                label: const Text('Limpar'),
                icon: const Icon(Icons.delete_forever),
              ),
              SizedBox(
                height: context.percentHeight(0.02),
              ),
              FloatingActionButton.extended(
                heroTag: 'save_all',
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                onPressed: () {
                  if (state.animals.isNotEmpty) {
                    controller.createAnimalsList(state.animals);
                    Navigator.of(context).pushNamed('/farm-animals',
                        arguments: {'farm': widget.farm});
                  } else {
                    showInfo('Nada para salvar');
                  }
                },
                label: const Text('Salvar'),
                icon: const Icon(Icons.save),
              ),
            ],
          ),
        );
      },
    );
  }
}
