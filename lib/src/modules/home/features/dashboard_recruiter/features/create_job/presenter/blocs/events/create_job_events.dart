part of "../blocs/create_job_bloc.dart";

abstract class CreateJobEvent extends Equatable {
  const CreateJobEvent();
}

class DoCreateJobEvent extends CreateJobEvent {
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

  const DoCreateJobEvent({
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

class CleanStateEvent extends CreateJobEvent {
  final CreateJobStates state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<CreateJobStates> get props => [state];
}
