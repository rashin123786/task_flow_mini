import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskflow_mini/data/models/subtask_model.dart';
import 'package:taskflow_mini/domain/entity/subtask_entity.dart';
import 'package:taskflow_mini/domain/repo/subtask_repo.dart';

class SubtaskRepoImpl implements SubtaskRepo {
  final Box<SubtaskModel> subtaskBox;
  SubtaskRepoImpl(this.subtaskBox);
  @override
  Future<void> createSubtasks(SubtaskEntity subtaskEntity) async {
    await subtaskBox.put(
      subtaskEntity.id,
      SubtaskModel.fromEntity(subtaskEntity),
    );
  }

  @override
  Future<List<SubtaskEntity>> fetchSubtasks(String taskId) async {
    final subTask = subtaskBox.values
        .where((element) => element.taskId == taskId)
        .map((e) => e.toEntity())
        .toList();
    return subTask;
  }
}
