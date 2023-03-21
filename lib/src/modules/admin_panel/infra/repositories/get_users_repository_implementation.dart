import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/repositories/get_users_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/models/get_users_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetUsersRepositoryImplementation implements GetUsersRepository {
  final GetUsersDatasource datasource;

  GetUsersRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      GetUsersResponseModel result = await datasource.getUsers();
      return Right(result.listUsers);
    } on InvalidCredentialsException catch (e) {
      return Left(InvalidCredentialsFailure(e.message.toString()));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(e.message.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
