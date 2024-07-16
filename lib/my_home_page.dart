import 'package:app_note/modele/task.dart';
import 'package:app_note/widget/task_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(tasksProvider).isEmpty ? listEmpty() : listIsNotEmpty(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

    Future <void> showDialogTask() async{

    final taskDialog= await showDialog(context: context, builder: (context) => const TaskDialog());
     if(taskDialog == null){
       return ;
     }

  }

  Widget listEmpty() => const Center(child: Text("votre liste est vide"));

  Widget listIsNotEmpty() => SizedBox(
        height: 300,
        width: 300,
        child: Center(
          child: Column(
            children: <Widget>[
              ListView.builder(
                  itemCount: ref.watch(tasksProvider).length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final task = ref.watch(tasksProvider)[index];

                    return CheckboxListTile(
                      title: Column(
                        children: [
                          Text(
                            task.name,
                            style: TextStyle(
                                decoration: task.done ? TextDecoration.lineThrough : null,
                                color: task.done ? Colors.grey : null),
                          ),
                          IconButton(
                              onPressed: () {
                                ref.read(tasksProvider.notifier).removeTask(task);
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                      value: task.done,
                      onChanged: (value) {
                        if (value == null) return;

                        ref.read(tasksProvider.notifier).onTaskStateChanged(index: index, value: value);
                      },
                    );
                  }),
            ],
          ),
        ),
      );

}
