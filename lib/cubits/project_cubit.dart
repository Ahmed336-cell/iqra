import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/project.dart';
import '../services/project_service.dart';

// Events
abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProjects extends ProjectEvent {}

class LoadProjectsByType extends ProjectEvent {
  final String type;

  const LoadProjectsByType(this.type);

  @override
  List<Object> get props => [type];
}

class LoadProjectBySlug extends ProjectEvent {
  final String slug;

  const LoadProjectBySlug(this.slug);

  @override
  List<Object> get props => [slug];
}

// States
abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectsLoaded extends ProjectState {
  final List<Project> projects;

  const ProjectsLoaded(this.projects);

  @override
  List<Object> get props => [projects];
}

class ProjectLoaded extends ProjectState {
  final Project project;

  const ProjectLoaded(this.project);

  @override
  List<Object> get props => [project];
}

class ProjectError extends ProjectState {
  final String message;

  const ProjectError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class ProjectCubit extends Cubit<ProjectState> {
  final ProjectService _projectService;

  ProjectCubit(this._projectService) : super(ProjectInitial());

  Future<void> loadAllProjects() async {
    emit(ProjectLoading());
    try {
      final projects = await _projectService.getAllProjects();
      emit(ProjectsLoaded(projects));
    } catch (e) {
      emit(ProjectError(e.toString()));
    }
  }

  Future<void> loadProjectsByType(String type) async {
    emit(ProjectLoading());
    try {
      final projects = await _projectService.getProjectsByType(type);
      emit(ProjectsLoaded(projects));
    } catch (e) {
      emit(ProjectError(e.toString()));
    }
  }

  Future<void> loadProjectBySlug(String slug) async {
    emit(ProjectLoading());
    try {
      final project = await _projectService.getProjectBySlug(slug);
      emit(ProjectLoaded(project));
    } catch (e) {
      emit(ProjectError(e.toString()));
    }
  }
} 