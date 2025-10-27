import 'package:taskflow_mini/domain/entity/subtask_entity.dart';

abstract class SubtaskRepo {
  Future<List<SubtaskEntity>> fetchSubtasks(String taskId);
  Future<void> createSubtasks(SubtaskEntity subtaskEntity);
}
