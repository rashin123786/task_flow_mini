import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskflow_mini/data/models/task_model.dart';
import 'package:taskflow_mini/domain/entity/task_entity.dart';
import 'package:taskflow_mini/domain/repo/task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final Box<TaskModel> taskBox;

  TaskRepoImpl(this.taskBox);
  @override
  Future<void> assignTask(String taskId, List<String> staffIds) async {
    final model = taskBox.get(taskId);
    if (model != null) {
      model.assignees = staffIds;
      await model.save();
    }
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    await taskBox.put(task.id, TaskModel.fromEntity(task));
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await taskBox.delete(taskId);
  }

  @override
  Future<List<TaskEntity>> fetchTasks(String projectId) async {
    await Future.delayed(Duration(milliseconds: 500));
    final tasks = taskBox.values
        .where((t) => t.projectId == projectId)
        .map((t) => t.toEntity())
        .toList();
    return tasks;
  }

  @override
  Future<void> unassignTask(String taskId, List<String> staffIds) async {
    final model = taskBox.get(taskId);
    if (model != null) {
      model.assignees?.removeWhere((id) => staffIds.contains(id));
      await model.save();
    }
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await taskBox.put(task.id, TaskModel.fromEntity(task));
  }
}
