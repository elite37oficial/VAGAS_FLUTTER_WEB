import 'package:equatable/equatable.dart';

class AdminChangeImageEntity extends Equatable {
  final String? companyId;
  final String? image64;

  const AdminChangeImageEntity({
    required this.companyId,
    required this.image64,
  });

  @override
  List<Object?> get props => [companyId, image64];
}
