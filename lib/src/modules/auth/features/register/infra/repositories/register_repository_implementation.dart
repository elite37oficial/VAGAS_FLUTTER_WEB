import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/models/register_model.dart';
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
        name: registerUser.name,
        phone: registerUser.phone,
        profileID: registerUser.profileID,
        email: registerUser.email,
        password: registerUser.password,
      );
      var result = await datasource.register(registerModel);
      return Right(result);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return Left(ServerFailure(e.response!.data["reason"].toString()));
      } else if (e.response!.statusCode == 400) {
        return Left(BadRequestFailure(e.response!.data["reason"].toString()));
      } else if (e.response!.statusCode == 403) {
        return Left(InvalidCredentialsFailure(e.toString()));
      } else {
        return Left(GeneralFailure(e.toString()));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
