part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();
}

class ProjectInitial extends ProjectState {
  @override
  List<Object> get props => [];
}

class ProjectLoading extends ProjectState {
  @override
  List<Object> get props => [];
}

// Hold both unarchived and archived separately
class ProjectLoaded extends ProjectState {
  final List<ProjectEntity> unarchivedProjects;
  final List<ProjectEntity> archivedProjects;

  const ProjectLoaded({
    this.unarchivedProjects = const [],
    this.archivedProjects = const [],
  });

  @override
  List<Object> get props => [unarchivedProjects, archivedProjects];

  // Helper to update unarchived or archived separately
  ProjectLoaded copyWith({
    List<ProjectEntity>? unarchivedProjects,
    List<ProjectEntity>? archivedProjects,
  }) {
    return ProjectLoaded(
      unarchivedProjects: unarchivedProjects ?? this.unarchivedProjects,
      archivedProjects: archivedProjects ?? this.archivedProjects,
    );
  }
}

class ProjectError extends ProjectState {
  final String message;
  const ProjectError(this.message);

  @override
  List<Object?> get props => [message];
}
