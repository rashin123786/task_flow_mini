import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_mini/domain/entity/task_entity.dart';
import 'package:taskflow_mini/presentation/viewmodels/tasks/bloc/task_bloc.dart';
import 'package:taskflow_mini/core/di/injection.dart';
import 'package:taskflow_mini/presentation/widgets/add_subtask_widget.dart';

import '../viewmodels/tasks/provider/task_controller.dart';

class TaskScreen extends StatelessWidget {
  final String projectId;

  const TaskScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskBloc>()..add(FetchTasks(projectId)),
      child: Scaffold(
        appBar: AppBar(title: Text("Tasks")),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              final tasks = state.tasks;
              if (tasks.isEmpty) {
                return Center(child: Text("No tasks found"));
              }
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final data = tasks[index];
                  return Column(
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                    ),
                                    onPressed: () async {
                                      Provider.of<TaskFormProvider>(
                                        context,
                                        listen: false,
                                      ).reset();
                                      final taskData = TaskEntity(
                                        id: data.id,
                                        projectId: projectId,
                                        title: data.title,
                                        startDate: data.startDate != null
                                            ? DateTime.parse(
                                                data.startDate!.toString(),
                                              )
                                            : null,
                                        dueDate: data.dueDate != null
                                            ? DateTime.parse(
                                                data.dueDate!.toString(),
                                              )
                                            : null,
                                        assignees: data.assignees ?? [],
                                        description: data.description ?? '',
                                        estimate: data.estimate ?? 0,
                                        labels: data.labels ?? [],
                                        priority: data.priority ?? '',
                                        status: data.status,
                                        timeSpent: data.timeSpent ?? 0,
                                      );
                                      final result = await context.pushNamed(
                                        'addtask',
                                        pathParameters: {
                                          "projectId": projectId,
                                          "isUpdate": "true",
                                        },
                                        extra: taskData,
                                      );
                                      if (result == true) {
                                        if (context.mounted) {
                                          context.read<TaskBloc>().add(
                                            FetchTasks(projectId),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                data.description ?? '',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Status: ${data.status ?? 'todo'}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Priority: ${data.priority ?? 'low'}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Assignees: ${data.assignees?.join(', ') ?? ''}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                "Time Spent: ${data.timeSpent}h / Estimate: ${data.estimate}h",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AddSubtaskWidget(projectId: projectId, taskId: data.id),
                      Divider(),
                    ],
                  );
                },
              );
            } else if (state is TaskError) {
              return Center(child: Text(state.message));
            }
            return SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await context.pushNamed(
              'addtask',
              pathParameters: {"projectId": projectId, "isUpdate": "false"},
              extra: null,
            );
            if (result == true) {
              if (context.mounted) {
                context.read<TaskBloc>().add(FetchTasks(projectId));
              }
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
