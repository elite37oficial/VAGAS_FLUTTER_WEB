
import 'package:equatable/equatable.dart';

abstract class ChangeImageEvent extends Equatable {
  const ChangeImageEvent();
}

class DoChangeImageEvent extends ChangeImageEvent {
  final String? companyId;
  final String? image64;

  const DoChangeImageEvent({
    required this.companyId,
    required this.image64,
  });

  @override
  List<Object?> get props => [companyId, image64];
}
