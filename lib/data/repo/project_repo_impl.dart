import 'package:hive_flutter/adapters.dart';
import 'package:taskflow_mini/data/models/project_model.dart';
import 'package:taskflow_mini/domain/entity/project_entity.dart';
import 'package:taskflow_mini/domain/repo/project_repo.dart';

class ProjectRepoImpl implements ProjectRepo {
  final Box<ProjectModel> box;
  ProjectRepoImpl(this.box);
  @override
  Future archieveProject(String projectId) async {
    await Future.delayed(Duration(milliseconds: 500));
    final model = box.get(projectId);
    if (model != null) {
      model.isArcheived = true;
      await model.save();
    }
  }

  @override
  Future createProject(ProjectEntity project) async {
    await Future.delayed(Duration(milliseconds: 500));
    await box.put(project.id, ProjectModel.fromEntity(project));
  }

  @override
  Future<List<ProjectEntity>> fetchProjects() async {
    final projects = box.values
        .where((element) => !element.isArcheived)
        .map((e) => e.toEntity())
        .toList();
    return projects;
  }

  @override
  Future updateProject(ProjectEntity project) async {
    await Future.delayed(Duration(milliseconds: 500));
    await box.put(project.id, ProjectModel.fromEntity(project));
  }

  @override
  Future<List<ProjectEntity>> fetchArchivedProjects() async {
    final projects = box.values
        .where((p) => p.isArcheived)
        .map((p) => p.toEntity())
        .toList();
    return projects;
  }

  @override
  Future<void> unarchiveProject(String projectId) async {
    final project = box.values.firstWhere((p) => p.id == projectId);
    project.isArcheived = false;
    await project.save();
  }

  @override
  Future<void> deleteAllProjects() async {
    await box.clear();
  }
}
