import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskflow_mini/presentation/viewmodels/project/bloc/project_bloc.dart';
import 'package:taskflow_mini/presentation/widgets/drawer_widget.dart';
import 'package:taskflow_mini/presentation/widgets/project_button_widget.dart';
import 'package:taskflow_mini/presentation/widgets/update_project_widget.dart';


// class ProjectScreen extends StatelessWidget {
//   const ProjectScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Wrap the entire screen with BlocProvider
//     return BlocProvider(
//       create: (_) => ProjectBloc(sl())..add(FetchProjects()),
//       child: const _ProjectScreenContent(),
//     );
//   }
// }

// class _ProjectScreenContent extends StatelessWidget {
//   const _ProjectScreenContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Projects')),
//       body: BlocBuilder<ProjectBloc, ProjectState>(
//         builder: (context, state) {
//           if (state is ProjectLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProjectLoaded) {
//             if (state.projects.isEmpty) {
//               return const Center(child: Text('No projects found.'));
//             }
//             return ListView.builder(
//               itemCount: state.projects.length,
//               itemBuilder: (context, index) {
//                 final project = state.projects[index];
//                 return ListTile(
//                   title: Text(project.name),
//                   subtitle: Text(project.description),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.archive),
//                     onPressed: () {
//                       context.read<ProjectBloc>().add(
//                         ArchieveProject(project.id),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           } else if (state is ProjectError) {
//             return Center(child: Text(state.message));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           final project = ProjectEntity(
//             id: DateTime.now().millisecondsSinceEpoch.toString(),
//             name: "Rashin",
//             description: "good boy 4",
//           );
//           // Use dialogContext to access Bloc safely
//           BlocProvider.of<ProjectBloc>(context).add(AddProject(project));
//         },
//       ),
//     );
//   }

//   void _showAddProjectDialog(BuildContext context) {
//     final nameController = TextEditingController();
//     final descController = TextEditingController();

//     // Use builder context to avoid Provider issues
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text('Add Project'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: descController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(dialogContext),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final project = ProjectEntity(
//                   id: DateTime.now().millisecondsSinceEpoch.toString(),
//                   name: nameController.text,
//                   description: descController.text,
//                 );
//                 // Use dialogContext to access Bloc safely
//                 BlocProvider.of<ProjectBloc>(
//                   dialogContext,
//                 ).add(AddProject(project));
//                 Navigator.pop(dialogContext);
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(title: Text("Projects")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ProjectButtonWidget(
                    text: "Create New Project",
                    onPressed: () {
                      showEditBottomSheet(context, null, false);
                    },
                  ),
                ),

                Expanded(
                  child: ProjectButtonWidget(
                    text: "Archived List",
                    onPressed: () {
                      context.pushNamed(
                        'archived',
                        extra: context.read<ProjectBloc>(),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "All List",
                style: GoogleFonts.varelaRound(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProjectLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.unarchivedProjects.length,
                      itemBuilder: (context, index) {
                        final data = state.unarchivedProjects[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                trailing: Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                                onTap: () {
                                  context.pushNamed(
                                    'task',
                                    pathParameters: {'projectId': data.id},
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 0.2,
                                  ),
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
                                      text: "Edit",
                                      onPressed: () {
                                        showEditBottomSheet(
                                          context,
                                          data,
                                          true,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ProjectButtonWidget(
                                      text: "Archive",
                                      onPressed: () {
                                        context.read<ProjectBloc>().add(
                                          ArchieveProject(data.id),
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
                    ),
                  );
                } else if (state is ProjectError) {
                  return Center(child: Text("Oops!...Please try again"));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
