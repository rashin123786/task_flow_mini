import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mini/domain/entity/project_entity.dart';

import '../viewmodels/project/bloc/project_bloc.dart';

void showEditBottomSheet(
  BuildContext context,
  ProjectEntity? project,
  bool isUpdate,
) {
  final fromKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: project?.name ?? "");
  final descController = TextEditingController(
    text: project?.description ?? '',
  );

  final bloc = context.read<ProjectBloc>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) {
      return BlocProvider.value(
        value: bloc,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 40,
            top: 16,
          ),
          child: Form(
            key: fromKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUpdate ? "Edit Project" : "Create Project",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name*';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Project Name"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        final projectEntity = ProjectEntity(
                          id: isUpdate
                              ? project!.id
                              : DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          name: nameController.text.trim(),
                          description: descController.text.trim(),
                        );
                        isUpdate
                            ? bloc.add(UpdateProject(projectEntity))
                            : bloc.add(AddProject(projectEntity));
                        Navigator.pop(sheetContext);
                      }
                    },
                    child: Text(isUpdate ? "Update" : "Add"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
