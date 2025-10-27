part of 'subtasks_bloc.dart';

abstract class SubtasksEvent extends Equatable {
  const SubtasksEvent();
}

class FetchSubtasks extends SubtasksEvent {
  final String taskId;
  const FetchSubtasks(this.taskId);
  @override
  List<Object?> get props => [taskId];
}

class CreateSubtask extends SubtasksEvent {
  final SubtaskEntity subtaskEntity;

  const CreateSubtask(this.subtaskEntity);

  @override
  List<Object?> get props => [subtaskEntity];
}
