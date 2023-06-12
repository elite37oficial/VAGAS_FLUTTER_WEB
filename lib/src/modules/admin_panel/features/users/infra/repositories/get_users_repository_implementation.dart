import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/get_users_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/repositories/get_users_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/datasources/get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/models/get_users_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetUsersRepositoryImplementation implements GetUsersRepository {
  final GetUsersDatasource datasource;

  GetUsersRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, GetUsersResponseEntity>> adminGetUsers(
      int page) async {
    try {
      GetUsersResponseModel result = await datasource.adminGetUsers(page);
      return Right(result);
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
