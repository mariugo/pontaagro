import 'package:flutter/material.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/presentation/widgets/animal_form.dart';
import 'package:pontaagro/features/farm_animals/presentation/widgets/animal_tile.dart';

class AddAnimalPage extends StatefulWidget {
  const AddAnimalPage({super.key});

  @override
  State<AddAnimalPage> createState() => _AddAnimalPageState();
}

class _AddAnimalPageState extends State<AddAnimalPage> {
  final formKey = GlobalKey<FormState>();
  final editFormKey = GlobalKey<FormState>();
  final animalNameController = TextEditingController();
  final tagController = TextEditingController();
  List<AnimalsModel> animals = [
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
  void dispose() {
    animalNameController.dispose();
    tagController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Fazenda >> Adicionar Animal',
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
                    setState(() {
                      animals.add(
                        AnimalsModel(
                          name: animalNameController.text,
                          tag: tagController.text,
                          farmId: 1,
                        ),
                      );
                    });
                    animalNameController.clear();
                    tagController.clear();
                  }
                },
              ),
              SizedBox(
                height: context.percentHeight(0.02),
              ),
              animals.isEmpty
                  ? Container()
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        itemCount: animals.length,
                        itemBuilder: (context, index) {
                          return AnimalTile(
                            canEdit: true,
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
                                    onPressed: () {},
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
                            onEdit: () async {
                              animalNameController.text = animals[index].name;
                              tagController.text = animals[index].tag;
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Editar animal'),
                                  content: SizedBox(
                                    //width: double.infinity,
                                    height: context.percentHeight(0.25),
                                    child: AnimalForm(
                                      canCancel: false,
                                      formKey: editFormKey,
                                      animalNameController:
                                          animalNameController,
                                      tagController: tagController,
                                      onSave: () async {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            animals[index] = AnimalsModel(
                                              name: animalNameController.text,
                                              tag: tagController.text,
                                              farmId: 1,
                                            );
                                          });
                                          animalNameController.clear();
                                          tagController.clear();
                                          Navigator.pop(context);
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: context.percentWidth(0.010),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        animals.clear();
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Sim',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.error)),
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
            onPressed: () {},
            label: const Text('Salvar'),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
