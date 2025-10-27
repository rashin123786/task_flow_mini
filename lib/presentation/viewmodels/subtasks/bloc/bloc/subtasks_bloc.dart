import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mini/domain/entity/subtask_entity.dart';
import 'package:taskflow_mini/domain/repo/subtask_repo.dart';

part 'subtasks_event.dart';
part 'subtasks_state.dart';

class SubtasksBloc extends Bloc<SubtasksEvent, SubtasksState> {
  final SubtaskRepo subtaskRepo;
  SubtasksBloc(this.subtaskRepo) : super(SubtasksInitial()) {
    on<CreateSubtask>(_onCreatesubtask);
    on<FetchSubtasks>(_onFetchSubtasks);
  }
  Future<void> _onCreatesubtask(
    CreateSubtask event,
    Emitter<SubtasksState> emit,
  ) async {
    emit(SubtaskLoading());
    try {
      await subtaskRepo.createSubtasks(event.subtaskEntity);
      final tasks = await subtaskRepo.fetchSubtasks(event.subtaskEntity.taskId);
      emit(SubtaskLoaded(tasks));
    } catch (e) {
      emit(SubtaskError("Failed to create subtask"));
    }
  }

  Future<void> _onFetchSubtasks(
    FetchSubtasks event,
    Emitter<SubtasksState> emit,
  ) async {
    emit(SubtaskLoading());
    try {
      final tasks = await subtaskRepo.fetchSubtasks(event.taskId);
      emit(SubtaskLoaded(tasks));
    } catch (e) {
      emit(SubtaskError("Failed to load tasks"));
    }
  }
}
