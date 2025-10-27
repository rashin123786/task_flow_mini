part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class FetchTasks extends TaskEvent {
  final String projectId;

  const FetchTasks(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class CreateTask extends TaskEvent {
  final TaskEntity task;

  const CreateTask(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final TaskEntity task;

  const UpdateTask(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String taskId;
  final String projectId;
  const DeleteTask(this.taskId, this.projectId);

  @override
  List<Object?> get props => [taskId, projectId];
}
