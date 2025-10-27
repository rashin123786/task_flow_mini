import '../entity/task_entity.dart';

abstract class TaskRepo {
  Future<List<TaskEntity>> fetchTasks(String projectId);
  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String taskId);
  Future<void> assignTask(String taskId, List<String> staffIds);
  Future<void> unassignTask(String taskId, List<String> staffIds);
}
