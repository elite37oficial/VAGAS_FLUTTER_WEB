import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String profileId;
  final bool isAdmin;
  final String name;
  final String email;
  final int createdDate;
  final String? about;
  final String? profession;
  final int? changedDate;
  final String? status;

  const UserEntity({
    required this.id,
    required this.profileId,
    required this.isAdmin,
    required this.name,
    required this.email,
    required this.createdDate,
    this.profession,
    this.changedDate,
    this.about,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        profileId,
        name,
        email,
        createdDate,
        changedDate,
        profession,
        about,
        status,
        isAdmin,
      ];
}
