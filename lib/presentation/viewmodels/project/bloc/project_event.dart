part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();
}

class FetchProjects extends ProjectEvent {
  @override
  List<Object?> get props => [];
}

class FetchArchivedProjects extends ProjectEvent {
  @override
  List<Object?> get props => [];
}

class AddProject extends ProjectEvent {
  final ProjectEntity projectEntity;
  const AddProject(this.projectEntity);

  @override
  List<Object?> get props => [projectEntity];
}

class UpdateProject extends ProjectEvent {
  final ProjectEntity projectEntity;
  const UpdateProject(this.projectEntity);

  @override
  List<Object?> get props => [projectEntity];
}

class ArchieveProject extends ProjectEvent {
  final String projectId;
  const ArchieveProject(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class UnarchiveProject extends ProjectEvent {
  final String projectId;
  const UnarchiveProject(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class DeleteAllProjects extends ProjectEvent {
  const DeleteAllProjects();

  @override
  List<Object?> get props => [];
}
