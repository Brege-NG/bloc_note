import 'package:flutter_riverpod/flutter_riverpod.dart';

class Task {
  final String name;
  final bool done;

  Task({required this.name, required this.done});

  Task copyWith({String? name, bool? done}) => Task(name: name ?? this.name, done: done ?? this.done);

  @override
  String toString() => "{name: $name, done: false)}";
}

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeTask(Task task) {
    state = state.where((ask) => ask != task).toList();
  }

  void onTaskStateChanged({required int index, required bool value}) {
    // var task = state[index];
    // task = task.copyWith(done: value);

    state[index] = state[index].copyWith(done: value);

    state = [...state];
  }
}
