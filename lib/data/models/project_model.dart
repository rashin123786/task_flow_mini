import 'package:hive_flutter/adapters.dart';
import 'package:taskflow_mini/domain/entity/project_entity.dart';
part 'project_model.g.dart';

@HiveType(typeId: 0)
class ProjectModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isArcheived;
  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    this.isArcheived = false,
  });
  // Hive model converting to Domain entity
  ProjectEntity toEntity() =>
      ProjectEntity(id: id, name: name, description: description);

  // Domain entity converting to Hive model

  factory ProjectModel.fromEntity(ProjectEntity entity) => ProjectModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    isArcheived: entity.isArchieved,
  );
}
