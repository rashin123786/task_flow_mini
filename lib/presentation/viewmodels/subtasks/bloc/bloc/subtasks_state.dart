part of 'subtasks_bloc.dart';

abstract class SubtasksState extends Equatable {
  const SubtasksState();

  @override
  List<Object> get props => [];
}

final class SubtasksInitial extends SubtasksState {}

class SubtaskLoading extends SubtasksState {}

class SubtaskLoaded extends SubtasksState {
  final List<SubtaskEntity> subtask;

  const SubtaskLoaded(this.subtask);

  @override
  List<Object> get props => [subtask];
}

class SubtaskError extends SubtasksState {
  final String message;

  const SubtaskError(this.message);

  @override
  List<Object> get props => [message];
}
