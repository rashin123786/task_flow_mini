import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskflow_mini/domain/entity/project_entity.dart';
import 'package:taskflow_mini/domain/repo/project_repo.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepo projectRepo;

  ProjectBloc(this.projectRepo) : super(ProjectInitial()) {
    on<FetchProjects>(_onLoadProjects);
    on<FetchArchivedProjects>(_onFetchArchivedProjects);
    on<AddProject>(_onAddProjects);
    on<UpdateProject>(_onUpdateProjects);
    on<ArchieveProject>(_archeiveProject);
    on<UnarchiveProject>(_onUnarchiveProject);
    on<DeleteAllProjects>(_onDeleteAllProjects);
  }

  // Load only unarchived projects
  Future _onLoadProjects(ProjectEvent event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    try {
      final unarchived = await projectRepo.fetchProjects();
      final archived = await projectRepo.fetchArchivedProjects();
      emit(
        ProjectLoaded(
          unarchivedProjects: unarchived,
          archivedProjects: archived,
        ),
      );
    } catch (e) {
      emit(ProjectError("Something went wrong"));
    }
  }

  // Load archived projects only
  Future _onFetchArchivedProjects(
    FetchArchivedProjects event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    try {
      final archived = await projectRepo.fetchArchivedProjects();
      final currentState = state is ProjectLoaded
          ? state as ProjectLoaded
          : null;
      emit(
        ProjectLoaded(
          unarchivedProjects: currentState?.unarchivedProjects ?? [],
          archivedProjects: archived,
        ),
      );
    } catch (e) {
      emit(ProjectError("Something went wrong"));
    }
  }

  // Add project
  Future _onAddProjects(AddProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepo.createProject(event.projectEntity);

      final unarchived = await projectRepo.fetchProjects();
      final archived = await projectRepo.fetchArchivedProjects();

      emit(
        ProjectLoaded(
          unarchivedProjects: unarchived,
          archivedProjects: archived,
        ),
      );
    } catch (e) {
      emit(ProjectError("Something went wrong"));
    }
  }

  // Update project
  Future _onUpdateProjects(
    UpdateProject event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await projectRepo.updateProject(event.projectEntity);

      final unarchived = await projectRepo.fetchProjects();
      final archived = await projectRepo.fetchArchivedProjects();

      emit(
        ProjectLoaded(
          unarchivedProjects: unarchived,
          archivedProjects: archived,
        ),
      );
    } catch (e) {
      emit(ProjectError("Something went wrong"));
    }
  }

  // Archive project
  Future _archeiveProject(
    ArchieveProject event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await projectRepo.archieveProject(event.projectId);

      final unarchived = await projectRepo.fetchProjects();
      final archived = await projectRepo.fetchArchivedProjects();
      emit(
        ProjectLoaded(
          unarchivedProjects: unarchived,
          archivedProjects: archived,
        ),
      );
    } catch (e) {
      emit(ProjectError("Something went wrong"));
    }
  }

  Future _onUnarchiveProject(
    UnarchiveProject event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await projectRepo.unarchiveProject(event.projectId);

      final unarchived = await projectRepo.fetchProjects();
      final archived = await projectRepo.fetchArchivedProjects();
      emit(
        ProjectLoaded(
          unarchivedProjects: unarchived,
          archivedProjects: archived,
        ),
      );
    } catch (e) {
      emit(ProjectError("Something went wrong"));
    }
  }

  Future _onDeleteAllProjects(
    DeleteAllProjects event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    try {
      await projectRepo.deleteAllProjects();
      emit(
        ProjectLoaded(unarchivedProjects: [], archivedProjects: []),
      ); // empty state
    } catch (e) {
      emit(ProjectError("Failed to delete projects"));
    }
  }
}
