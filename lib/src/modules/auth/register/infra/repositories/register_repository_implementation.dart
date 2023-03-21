import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/datasources/register_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/models/register_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class RegisterRepositoryImplementation implements RegisterRepository {
  final RegisterDatasource datasource;

  RegisterRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, RegisterUserEntity>> register(
      RegisterEntity registerUser) async {
    try {
      RegisterModel registerModel = RegisterModel(
        company: registerUser.company,
        email: registerUser.email,
        password: registerUser.password,
      );
      final result = await datasource.register(registerModel);
      return Right(result);
    } on InvalidCredentialsException catch (e) {
      return Left(InvalidCredentialsFailure(e.message.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
