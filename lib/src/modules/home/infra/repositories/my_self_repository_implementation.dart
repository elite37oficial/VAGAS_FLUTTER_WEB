
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/home/domain/repositories/my_self_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/infra/datasources/my_self_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class MySelfRepositoryImplementation implements MySelfRepository {
  final MySelfDatasource datasource;

  MySelfRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, UserEntity>> getMySelf(String userId) async {
    try {
      var result = await datasource.getMySelf(userId);
      return Right(result);
    } on InvalidCredentialsException catch (e) {
      return Left(InvalidCredentialsFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(e.toString()));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
