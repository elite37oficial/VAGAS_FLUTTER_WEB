import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  final String token;

  const TokenEntity({required this.token});

  @override
  List<String> get props => [token];
}
