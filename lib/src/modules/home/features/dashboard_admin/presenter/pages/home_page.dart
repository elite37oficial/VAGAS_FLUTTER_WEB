import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_admin/domain/usecases/my_self_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_admin/infra/datasources/my_self_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_admin/infra/repositories/my_self_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/themes/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserEntity? userEntity;
  bool isLoading = false;

  getMySelf() async {
    setState(() {
      isLoading = true;
    });
    MySelfUsecase usecase = MySelfUsecase(
      repository: MySelfRepositoryImplementation(
        datasource: MySelfDatasourceImplementation(
          requester: AppRequesterImplementation(),
        ),
      ),
    );

    var result = await usecase("123");

    result.fold(
      (Failure failure) => log(failure.props.first.toString()),
      (UserEntity success) => userEntity = success,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getMySelf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            const Text("Infos"),
            Text(userEntity?.email ?? ""),
            Text(userEntity?.name ?? ""),
            Text(userEntity?.id ?? ""),
          ],
        ),
      ),
    );
  }
}
