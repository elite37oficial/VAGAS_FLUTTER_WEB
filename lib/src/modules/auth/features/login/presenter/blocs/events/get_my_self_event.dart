import 'package:equatable/equatable.dart';

abstract class GetMySelfEvent extends Equatable {
  const GetMySelfEvent();
}

class DoGetMySelfEvent extends GetMySelfEvent {
  final String email;
  final String token;

  const DoGetMySelfEvent({
    required this.email,
    required this.token,
  });

  @override
  List<Object> get props => [email, token];
}
