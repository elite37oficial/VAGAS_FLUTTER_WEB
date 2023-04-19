import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/get_my_self_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/repositories/get_my_self_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/get_my_self_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/models/get_my_self_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetMySelfRepositoryImplementation implements GetMySelfRepository {
  final GetMySelfDatasource datasource;

  const GetMySelfRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, bool>> getMySelf(GetMySelfEntity getMySelfData) async {
    try {
      GetMySelfModel getMySelfModel = GetMySelfModel(
        email: getMySelfData.email,
        token: getMySelfData.token,
      );

      var result = await datasource.getMySelf(getMySelfModel);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
