import 'package:taskflow_mini/domain/entity/project_entity.dart';

abstract class ProjectRepo {
  Future<List<ProjectEntity>> fetchProjects();
  Future<List<ProjectEntity>> fetchArchivedProjects();
  Future createProject(ProjectEntity project);
  Future updateProject(ProjectEntity project);
  Future archieveProject(String projectId);
  Future<void> unarchiveProject(String projectId);
  Future<void> deleteAllProjects();
}
