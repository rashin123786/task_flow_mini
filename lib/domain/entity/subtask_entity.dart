import 'package:equatable/equatable.dart';

class SubtaskEntity extends Equatable {
  final String id;
  final String projectId;
  final String taskId;
  final String title;
  final String? status;
  const SubtaskEntity({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.title,
    this.status,
  });
  @override
  List<Object?> get props => [id, projectId, taskId, title, status];
}
