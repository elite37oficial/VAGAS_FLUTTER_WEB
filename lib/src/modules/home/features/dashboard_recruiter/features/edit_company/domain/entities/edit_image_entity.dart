import 'package:equatable/equatable.dart';

class EditImageEntity extends Equatable {
  final String companyId;
  final String image64;

  const EditImageEntity({
    required this.companyId,
    required this.image64,
  });

  @override
  List<Object?> get props => [companyId, image64];
}
