import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_company_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/repositories/edit_company_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/datasources/edit_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/models/edit_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class EditCompanyRepositoryImplementation extends EditCompanyRepository {
  final EditCompanyDatasource datasource;

  EditCompanyRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, bool>> editCompany(
      EditCompanyEntity editCompanyData) async {
    try {
      EditCompanyModel editCompanyModel = EditCompanyModel(
        id: editCompanyData.id,
        name: editCompanyData.name,
        location: editCompanyData.location,
        description: editCompanyData.description,
      );

      await datasource.editCompany(editCompanyModel);

      return const Right(true);
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return Left(ServerFailure(e.response!.data["reason"].toString()));
      } else if (e.response!.statusCode == 400) {
        return Left(BadRequestFailure(e.response!.data["reason"].toString()));
      } else {
        return Left(GeneralFailure(e.toString()));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
