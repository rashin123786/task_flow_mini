import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String projectId;
  final String title;
  final String? description;
  final String? status;
  final String? priority;
  final DateTime? startDate;
  final DateTime? dueDate;
  final double? estimate;
  final double? timeSpent;
  final List<String>? labels;
  final List<String>? assignees;
  const TaskEntity({
    required this.id,
    required this.projectId,
    required this.title,
    this.description,
    this.status,
    this.priority,
    required this.startDate,
    required this.dueDate,
    this.estimate = 0,
    this.timeSpent = 0,
    this.labels = const [],
    this.assignees = const [],
  });

  @override
  List<Object?> get props => [
    id,
    projectId,
    title,
    description,
    status,
    priority,
    startDate,
    dueDate,
    estimate,
    timeSpent,
    labels,
    assignees,
  ];
}
