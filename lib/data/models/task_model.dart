import '../../domain/entity/task_entity.dart';
import 'package:hive_flutter/adapters.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String projectId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? status;

  @HiveField(5)
  String? priority;

  @HiveField(6)
  DateTime? startDate;

  @HiveField(7)
  DateTime? dueDate;

  @HiveField(8)
  double? estimate;

  @HiveField(9)
  double? timeSpent;

  @HiveField(10)
  List<String>? labels;

  @HiveField(11)
  List<String>? assignees;

  TaskModel({
    required this.id,
    required this.projectId,
    required this.title,
    this.description,
    this.status,
    this.priority,
    this.startDate,
    this.dueDate,
    this.estimate = 0,
    this.timeSpent = 0,
    this.labels = const [],
    this.assignees = const [],
  });

  TaskEntity toEntity() => TaskEntity(
    id: id,
    projectId: projectId,
    title: title,
    description: description ?? "",
    status: status ?? "",
    priority: priority ?? "",
    startDate: startDate,
    dueDate: dueDate,
    estimate: estimate ?? 0,
    timeSpent: timeSpent ?? 0,
    labels: labels ?? [''],
    assignees: assignees ?? [''],
  );

  factory TaskModel.fromEntity(TaskEntity entity) => TaskModel(
    id: entity.id,
    projectId: entity.projectId,
    title: entity.title,
    description: entity.description,
    status: entity.status,
    priority: entity.priority,
    startDate: entity.startDate,
    dueDate: entity.dueDate,
    estimate: entity.estimate,
    timeSpent: entity.timeSpent,
    labels: entity.labels,
    assignees: entity.assignees,
  );
}
