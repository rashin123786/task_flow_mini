import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mini/core/di/injection.dart';
import 'package:taskflow_mini/domain/entity/subtask_entity.dart';
import 'package:taskflow_mini/presentation/viewmodels/subtasks/bloc/bloc/subtasks_bloc.dart';
import 'package:taskflow_mini/presentation/widgets/project_button_widget.dart';

class AddSubtaskWidget extends StatelessWidget {
  AddSubtaskWidget({super.key, required this.projectId, required this.taskId});
  final String projectId;
  final String taskId;
  final titleController = TextEditingController();
  final statusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Expanded(
              child: ExpansionTile(
                title: Text("Add Subtask"),
                onExpansionChanged: (value) {},
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title*';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                  TextFormField(
                    controller: statusController,
                    decoration: const InputDecoration(labelText: "Status"),
                  ),
                  ProjectButtonWidget(
                    text: "Submit",
                    onPressed: () {
                      final data = SubtaskEntity(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        projectId: projectId,
                        taskId: taskId,
                        title: titleController.text.trim(),
                        status: statusController.text.trim(),
                      );
                      if (_formKey.currentState!.validate()) {
                        context.read<SubtasksBloc>().add(CreateSubtask(data));
                        titleController.clear();
                        statusController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ExpansionTile(
                title: Text("View Subtasks"),
                children: [
                  BlocProvider(
                    create: (context) =>
                        sl<SubtasksBloc>()..add(FetchSubtasks(taskId)),
                    child: BlocBuilder<SubtasksBloc, SubtasksState>(
                      builder: (context, state) {
                        if (state is SubtaskLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is SubtaskLoaded) {
                          final result = state.subtask;
                          if (result.isEmpty) {
                            return Center(child: Text("Empty List"));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              final data = result[index];
                              return ListTile(
                                isThreeLine: false,
                                title: Text(data.title),
                                subtitle: Text(data.status ?? ""),
                              );
                            },
                          );
                        } else if (state is SubtaskError) {
                          return Center(child: Text("Something went wrong"));
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
