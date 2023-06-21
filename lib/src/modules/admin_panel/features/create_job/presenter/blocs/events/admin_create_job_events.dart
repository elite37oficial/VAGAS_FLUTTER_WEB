import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/states/admin_create_job_states.dart';

abstract class AdminCreateJobEvent extends Equatable {
  const AdminCreateJobEvent();
}

class DoAdminCreateJobEvent extends AdminCreateJobEvent {
  final String title;
  final String description;
  final String companyDescription;
  final String companyId;
  final String type;
  final String userId;
  final String level;
  final String phone;
  final String email;
  final String link;
  final String modality;
  final double salary;
  final String state;
  final String city;

  const DoAdminCreateJobEvent({
    required this.title,
    required this.description,
    required this.companyDescription,
    required this.companyId,
    required this.userId,
    required this.type,
    required this.level,
    required this.phone,
    required this.email,
    required this.modality,
    required this.link,
    required this.salary,
    required this.state,
    required this.city,
  });

  @override
  List<Object> get props => [
        userId,
        title,
        description,
        companyDescription,
        companyId,
        type,
        level,
        phone,
        email,
        link,
        modality,
        salary,
        city,
        state,
      ];
}

class CleanStateEvent extends AdminCreateJobEvent {
  final AdminCreateJobStates state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<AdminCreateJobStates> get props => [state];
}
