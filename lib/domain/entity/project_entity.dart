import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool isArchieved;
  const ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    this.isArchieved = false,
  });
  @override
  List<Object?> get props => [id, name, description, isArchieved];
}
