import 'package:hive_flutter/adapters.dart';
import 'package:taskflow_mini/domain/entity/subtask_entity.dart';
part 'subtask_model.g.dart';

@HiveType(typeId: 2)
class SubtaskModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String projectId;

  @HiveField(2)
  String taskId;
  @HiveField(3)
  String title;

  @HiveField(4)
  String? status;
  SubtaskModel({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.title,
    this.status,
  });

  SubtaskEntity toEntity() => SubtaskEntity(
    id: id,
    projectId: projectId,
    taskId: taskId,
    title: title,
    status: status ?? "",
  );
  factory SubtaskModel.fromEntity(SubtaskEntity subtaskModel) => SubtaskModel(
    id: subtaskModel.id,
    projectId: subtaskModel.projectId,
    taskId: subtaskModel.taskId,
    title: subtaskModel.title,
    status: subtaskModel.status ?? '',
  );
}
