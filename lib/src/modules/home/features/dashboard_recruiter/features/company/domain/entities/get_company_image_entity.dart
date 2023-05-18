import 'package:equatable/equatable.dart';

class GetCompanyImageEntity extends Equatable {
  final String? companyId;
  final String image64;

  const GetCompanyImageEntity({
    this.companyId,
    required this.image64,
  });

  @override
  List<Object> get props => [image64];
}
