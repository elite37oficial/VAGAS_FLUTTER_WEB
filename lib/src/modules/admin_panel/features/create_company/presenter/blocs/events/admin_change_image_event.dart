import 'package:equatable/equatable.dart';

abstract class AdminChangeImageEvent extends Equatable {
  const AdminChangeImageEvent();
}

class DoAdminChangeImageEvent extends AdminChangeImageEvent {
  final String? companyId;
  final String? image64;

  const DoAdminChangeImageEvent({
    required this.companyId,
    required this.image64,
  });

  @override
  List<Object?> get props => [companyId, image64];
}
