import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskflow_mini/data/models/project_model.dart';
import 'package:taskflow_mini/data/models/subtask_model.dart';
import 'package:taskflow_mini/data/repo/project_repo_impl.dart';
import 'package:taskflow_mini/data/repo/subtask_repo.dart';
import 'package:taskflow_mini/data/repo/task_repo.dart';
import 'package:taskflow_mini/domain/repo/project_repo.dart';
import 'package:taskflow_mini/domain/repo/subtask_repo.dart';
import 'package:taskflow_mini/presentation/viewmodels/subtasks/bloc/bloc/subtasks_bloc.dart';
import 'package:taskflow_mini/presentation/viewmodels/tasks/bloc/task_bloc.dart';

import '../../data/models/task_model.dart';
import '../../domain/repo/task_repo.dart';
import '../../presentation/viewmodels/project/bloc/project_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProjectModelAdapter());
  final projectBox = await Hive.openBox<ProjectModel>('projects');

  sl.registerLazySingleton<ProjectRepo>(() => ProjectRepoImpl(projectBox));
  sl.registerFactory<ProjectBloc>(() => ProjectBloc(sl<ProjectRepo>()));

  Hive.registerAdapter(TaskModelAdapter());
  final taskBox = await Hive.openBox<TaskModel>('tasks');
  sl.registerLazySingleton<TaskRepo>(() => TaskRepoImpl(taskBox));
  sl.registerFactory<TaskBloc>(() => TaskBloc(sl<TaskRepo>()));

  Hive.registerAdapter(SubtaskModelAdapter());
  final subtaskBox = await Hive.openBox<SubtaskModel>('subtasks');
  sl.registerLazySingleton<SubtaskRepo>(() => SubtaskRepoImpl(subtaskBox));
  sl.registerFactory<SubtasksBloc>(() => SubtasksBloc(sl<SubtaskRepo>()));
}
