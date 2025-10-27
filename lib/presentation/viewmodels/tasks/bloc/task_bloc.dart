import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskflow_mini/domain/entity/task_entity.dart';
import 'package:taskflow_mini/domain/repo/task_repo.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepo taskRepo;

  TaskBloc(this.taskRepo) : super(TaskInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<CreateTask>(_onCreateTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await taskRepo.fetchTasks(event.projectId);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Failed to load tasks"));
    }
  }

  Future<void> _onCreateTask(CreateTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await taskRepo.createTask(event.task);
      final tasks = await taskRepo.fetchTasks(event.task.projectId);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Failed to create task"));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await taskRepo.updateTask(event.task);
      final tasks = await taskRepo.fetchTasks(event.task.projectId);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Failed to update task"));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await taskRepo.deleteTask(event.taskId);
      final tasks = await taskRepo.fetchTasks(event.projectId);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Failed to delete task"));
    }
  }
}
