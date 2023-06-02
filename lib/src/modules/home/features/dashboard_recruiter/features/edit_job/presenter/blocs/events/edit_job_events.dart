part of '../blocs/edit_job_bloc.dart';

abstract class EditJobEvent extends Equatable {
  const EditJobEvent();
}

class DoEditJobEvent extends EditJobEvent {
  final String status;
  final String id;
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

  const DoEditJobEvent({
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
    required this.id,
    required this.status,
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
        status,
        id,
      ];
}

class CleanStateEvent extends EditJobEvent {
  final EditJobStates state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<EditJobStates> get props => [state];
}
