import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../modele/task.dart';

class TaskDialog extends ConsumerStatefulWidget {
  const TaskDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<TaskDialog> createState() => TaskDialogState();
}

class TaskDialogState extends ConsumerState<TaskDialog> {
  late final TextEditingController taskController;

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Column(
        children: [
          const Text("ajoutez une tache ici svp"),
          const Text("pas trop long svp", style: TextStyle(
            fontSize: 10.0, color: Colors.red,
          ),),
          const Text("pas trop long",style: TextStyle(
            fontSize: 8.0, color: Colors.red,
          ),),
          const SizedBox(
            height: 5.0,
          ),
          TextField(
            controller: taskController,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("annuler")),
        TextButton(
            onPressed: () {
              ref.read(tasksProvider.notifier).addTask(Task(name: taskController.text, done: false));
              taskController.clear();
              Navigator.pop(context);
            },
            child: const Text("ajouter")),
      ],
    );
  }
}
