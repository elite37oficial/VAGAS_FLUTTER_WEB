import 'package:equatable/equatable.dart';

abstract class EditImageEvent extends Equatable {
  const EditImageEvent();
}

class DoEditImageEvent extends EditImageEvent {
  final String? companyId;
  final String? image64;

  const DoEditImageEvent({
    required this.companyId,
    required this.image64,
  });

  @override
  List<Object?> get props => [companyId, image64];
}
