import 'package:flutter/material.dart';
import 'package:vagas_design_system/vagas_design_system.dart';

class RedirectPageRoute extends StatefulWidget {
  final String redirectRoute;
  final Duration duration;
  final dynamic args;
  const RedirectPageRoute({
    Key? key,
    required this.duration,
    required this.redirectRoute,
    this.args,
  }) : super(key: key);

  @override
  State<RedirectPageRoute> createState() => _RedirectPageRouteState();
}

class _RedirectPageRouteState extends State<RedirectPageRoute> {
  _goTo(BuildContext context) {
    Future.delayed(widget.duration);
    _route(context);
  }

  _route(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Navigator.pushReplacementNamed(context, widget.redirectRoute,
          arguments: widget.args);
    });
  }

  @override
  void initState() {
    super.initState();
    _route(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: SizedBox(
            height: size.height * 0.65,
            child: SvgPicture.asset(
              AppImages.logoVagas,
              fit: BoxFit.fitWidth,
              color: AppColors.darkBlue,
              package: "vagas_design_system",
            ),
          ),
        ),
      ),
    );
  }
}
