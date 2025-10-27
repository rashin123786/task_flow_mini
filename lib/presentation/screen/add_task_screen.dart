import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_mini/domain/entity/task_entity.dart';
import '../viewmodels/tasks/bloc/task_bloc.dart';
import '../viewmodels/tasks/provider/task_controller.dart';

class CreateTaskScreen extends StatelessWidget {
  final String projectId;
  final TaskEntity? taskEntity;
  final bool isUpdate;
  const CreateTaskScreen({
    super.key,
    required this.projectId,
    this.taskEntity,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(
      text: taskEntity?.title ?? '',
    );
    final descriptionController = TextEditingController(
      text: taskEntity?.description ?? '',
    );
    final estimateController = TextEditingController(
      text: taskEntity?.estimate.toString() ?? '',
    );
    final timeSpentController = TextEditingController(
      text: taskEntity?.timeSpent.toString() ?? '',
    );
    final labelsController = TextEditingController(
      text: taskEntity?.labels?.join(', ') ?? '',
    );
    final assigneeController = TextEditingController(
      text: taskEntity?.assignees?.join(', ') ?? "",
    );
    String? status = taskEntity?.status ?? 'todo';
    String? priority = taskEntity?.priority ?? 'low';

    final formKey = GlobalKey<FormState>();
    final taskController = Provider.of<TaskFormProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title*';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // DESCRIPTION
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),

                // PRIORITY DROPDOWN
                DropdownButtonFormField<String>(
                  initialValue: priority,
                  items: ['low', 'medium', 'high', 'critical']
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (val) => priority = val ?? 'low',
                  decoration: const InputDecoration(labelText: "Priority"),
                ),
                const SizedBox(height: 12),

                // STATUS DROPDOWN
                DropdownButtonFormField<String>(
                  initialValue: status,
                  items: ['todo', 'inProgress', 'blocked', 'inReview', 'done']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => status = val ?? 'todo',
                  decoration: const InputDecoration(labelText: "Status"),
                ),
                const SizedBox(height: 12),

                // START DATE
                Consumer<TaskFormProvider>(
                  builder: (_, value, __) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      value.startDate == null
                          ? taskEntity?.startDate == null
                                ? "Select Start Date"
                                : "Start: ${taskEntity!.startDate!.toLocal().toString().substring(0, 10)}"
                          : "Start: ${value.startDate!.toLocal().toString().substring(0, 10)}",
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) taskController.setStartDate(picked);
                    },
                  ),
                ),

                // DUE DATE
                Consumer<TaskFormProvider>(
                  builder: (_, value, __) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      value.dueDate == null
                          ? taskEntity?.dueDate == null
                                ? "Select Due Date"
                                : "Due: ${taskEntity!.dueDate!.toLocal().toString().substring(0, 10)}"
                          : "Due: ${value.dueDate!.toLocal().toString().substring(0, 10)}",
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        taskController.setDueDate(picked);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // ESTIMATE HOURS
                TextFormField(
                  controller: estimateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Estimate (hours)",
                  ),
                ),
                const SizedBox(height: 12),

                // TIME SPENT
                TextFormField(
                  controller: timeSpentController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Time Spent (hours)",
                  ),
                ),
                const SizedBox(height: 12),

                // LABELS
                TextFormField(
                  controller: labelsController,
                  decoration: const InputDecoration(
                    labelText: "Labels (comma-separated)",
                  ),
                ),
                const SizedBox(height: 12),

                // ASSIGNEES
                TextFormField(
                  controller: assigneeController,
                  decoration: const InputDecoration(
                    labelText: "Assignees (comma-separated)",
                  ),
                ),
                const SizedBox(height: 24),

                // CREATE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final task = TaskEntity(
                          id: !isUpdate
                              ? DateTime.now().millisecondsSinceEpoch.toString()
                              : taskEntity!.id,
                          projectId: projectId,
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          status: status,
                          priority: priority,
                          startDate: taskController.startDate,
                          dueDate: taskController.dueDate,
                          estimate:
                              double.tryParse(estimateController.text) ?? 0,
                          timeSpent:
                              double.tryParse(timeSpentController.text) ?? 0,
                          labels: labelsController.text
                              .split(',')
                              .map((e) => e.trim())
                              .toList(),
                          assignees: assigneeController.text
                              .split(',')
                              .map((e) => e.trim())
                              .toList(),
                        );

                        !isUpdate
                            ? context.read<TaskBloc>().add(CreateTask(task))
                            : context.read<TaskBloc>().add(UpdateTask(task));
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text(!isUpdate ? "Create Task" : "Update Task"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
