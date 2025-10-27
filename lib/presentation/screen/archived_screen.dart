import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskflow_mini/presentation/viewmodels/project/bloc/project_bloc.dart';

import '../widgets/project_button_widget.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Archived List")),

      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProjectLoaded) {
            return ListView.builder(
              itemCount: state.archivedProjects.length,
              itemBuilder: (context, index) {
                final data = state.archivedProjects[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        trailing: Icon(Icons.arrow_circle_right_outlined),
                        onTap: () {
                          context.pushNamed(
                            'task',
                            pathParameters: {'projectId': data.id},
                          );
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 0.2),
                        ),
                        title: Text(data.name),
                        subtitle: Text(data.description),
                      ),
                      SizedBox(height: 3),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: ProjectButtonWidget(
                              text: "Unarchive",
                              onPressed: () {
                                context.read<ProjectBloc>().add(
                                  UnarchiveProject(data.id),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ProjectError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
