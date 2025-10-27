
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskflow_mini/presentation/screen/add_task_screen.dart';
import 'package:taskflow_mini/presentation/screen/archived_screen.dart';
import 'package:taskflow_mini/presentation/screen/task_screen.dart';
import 'package:taskflow_mini/presentation/viewmodels/tasks/bloc/task_bloc.dart';

import '../../domain/entity/task_entity.dart';
import '../../presentation/screen/project_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/projects',
  routes: [
    GoRoute(
      path: '/projects',
      name: 'projects',
      builder: (context, state) => ProjectScreen(),
    ),
    GoRoute(
      path: '/archived',
      name: 'archived',
      builder: (context, state) => ArchivedScreen(),
    ),
    GoRoute(
      path: '/task/:projectId',
      name: 'task',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;

        return TaskScreen(projectId: projectId);
      },
    ),
    GoRoute(
      path: '/addtask/:projectId/:isUpdate',
      name: 'addtask',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;
        final isUpdateString = state.pathParameters['isUpdate']!;
        final isUpdate = isUpdateString == 'true';
        final taskEntity = state.extra as TaskEntity?;
        final taskBloc = BlocProvider.of<TaskBloc>(context);
        return BlocProvider.value(
          value: taskBloc,
          child: CreateTaskScreen(
            projectId: projectId,
            isUpdate: isUpdate,
            taskEntity: taskEntity,
          ),
        );
      },
    ),
  ],
);
