// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:taskflow_mini/data/models/task_model.dart';
// import 'package:taskflow_mini/domain/entity/task_entity.dart';
// import 'package:taskflow_mini/presentation/viewmodels/tasks/bloc/task_bloc.dart';

// import '../viewmodels/tasks/provider/task_controller.dart';

// void showCreateTaskBottomSheet(BuildContext context, String projectId) {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final estimateController = TextEditingController();
//   final timeSpentController = TextEditingController();
//   final labelsController = TextEditingController();
//   final assigneeController = TextEditingController();
//   final taskController = Provider.of<TaskFormProvider>(context, listen: false);
//   final _formKey = GlobalKey<FormState>();

//   String status = 'todo';
//   String priority = 'low';

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (sheetContext) {
//       return Padding(
//         padding: EdgeInsets.only(
//           left: 16,
//           right: 16,
//           bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
//           top: 16,
//         ),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Create Task",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 12),

//                 // TITLE
//                 TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter title*';
//                     }
//                     return null;
//                   },
//                   controller: titleController,
//                   decoration: const InputDecoration(labelText: "Title"),
//                 ),
//                 const SizedBox(height: 8),

//                 // DESCRIPTION
//                 TextFormField(
//                   controller: descriptionController,
//                   decoration: const InputDecoration(labelText: "Description"),
//                   maxLines: 2,
//                 ),
//                 const SizedBox(height: 8),

//                 // PRIORITY DROPDOWN
//                 DropdownButtonFormField<String>(
//                   initialValue: priority,
//                   items: ['low', 'medium', 'high', 'critical']
//                       .map(
//                         (p) => DropdownMenuItem(
//                           value: p,
//                           child: Text(p),
//                           onTap: () {
//                             priority = p;
//                             print(priority);
//                           },
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (val) => priority = val ?? 'low',
//                   decoration: const InputDecoration(labelText: "Priority"),
//                 ),
//                 const SizedBox(height: 8),

//                 // STATUS DROPDOWN
//                 DropdownButtonFormField<String>(
//                   initialValue: status,
//                   items: ['todo', 'inProgress', 'blocked', 'inReview', 'done']
//                       .map(
//                         (s) => DropdownMenuItem(
//                           value: s,
//                           child: Text(s),
//                           onTap: () {
//                             status = s;
//                           },
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (val) => status = val ?? 'todo',

//                   decoration: const InputDecoration(labelText: "Status"),
//                 ),
//                 const SizedBox(height: 8),

//                 // START DATE
//                 Consumer<TaskFormProvider>(
//                   builder: (sheetContext, value, child) => ListTile(
//                     title: Text(
//                       value.startDate == null
//                           ? "Select Start Date"
//                           : "Start: ${value.startDate!.toLocal().toString().substring(0, 10)}",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     trailing: const Icon(Icons.calendar_today),
//                     onTap: () async {
//                       final picked = await showDatePicker(
//                         context: sheetContext,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2020),
//                         lastDate: DateTime(2100),
//                       );

//                       if (picked != null) taskController.setStartDate(picked);
//                     },
//                   ),
//                 ),

//                 // Due Date (with Provider)
//                 Consumer<TaskFormProvider>(
//                   builder: (context, value, child) => ListTile(
//                     title: Text(
//                       taskController.dueDate == null
//                           ? "Select Due Date"
//                           : "Due: ${value.dueDate!.toLocal().toString().substring(0, 10)}",
//                     ),
//                     trailing: const Icon(Icons.calendar_today),
//                     onTap: () async {
//                       final picked = await showDatePicker(
//                         context: sheetContext,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2020),
//                         lastDate: DateTime(2100),
//                       );
//                       if (picked != null) taskController.setDueDate(picked);
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 // ESTIMATE HOURS
//                 TextFormField(
//                   controller: estimateController,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [],
//                   decoration: const InputDecoration(
//                     labelText: "Estimate (hours)",
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // TIME SPENT
//                 TextFormField(
//                   controller: timeSpentController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: "Time Spent (hours)",
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // LABELS
//                 TextFormField(
//                   controller: labelsController,
//                   decoration: const InputDecoration(
//                     labelText: "Labels (comma-separated)",
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // ASSIGNEES
//                 TextFormField(
//                   controller: assigneeController,
//                   decoration: const InputDecoration(
//                     labelText: "Assignees (comma-separated)",
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // CREATE BUTTON
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       final task = TaskEntity(
//                         id: DateTime.now().millisecondsSinceEpoch.toString(),
//                         projectId: projectId,
//                         title: titleController.text.trim(),
//                         description: descriptionController.text.trim(),
//                         status: status,
//                         priority: priority,
//                         startDate: taskController.startDate,
//                         dueDate: taskController.dueDate,
//                         estimate: double.tryParse(estimateController.text) ?? 0,
//                         timeSpent:
//                             double.tryParse(timeSpentController.text) ?? 0,
//                         labels: labelsController.text
//                             .split(',')
//                             .map((e) => e.trim())
//                             .toList(),
//                         assignees: assigneeController.text
//                             .split(',')
//                             .map((e) => e.trim())
//                             .toList(),
//                       );

//                       context.read<TaskBloc>().add(CreateTask(task));
//                       Navigator.pop(sheetContext);
//                     }
//                   },
//                   child: const Text("Create Task"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
