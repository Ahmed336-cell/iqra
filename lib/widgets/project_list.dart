import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/project_cubit.dart';
import '../models/project.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state is ProjectInitial) {
          context.read<ProjectCubit>().loadAllProjects();
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProjectLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProjectError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is ProjectsLoaded) {
          return ListView.builder(
            itemCount: state.projects.length,
            itemBuilder: (context, index) {
              final project = state.projects[index];
              return ProjectListItem(project: project);
            },
          );
        }

        return const Center(child: Text('No projects found'));
      },
    );
  }
}

class ProjectListItem extends StatelessWidget {
  final Project project;

  const ProjectListItem({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          project.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              project.localeType,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              project.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        onTap: () {
          // TODO: Navigate to project detail page
        },
      ),
    );
  }
} 