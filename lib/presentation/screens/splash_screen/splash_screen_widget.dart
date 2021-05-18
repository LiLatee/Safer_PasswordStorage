import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/AppConstants.dart';
import '../../../logic/cubit/general/launching_cubit.dart';
import '../../../logic/cubit/general/login_cubit.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    this._dispatchEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            AppConstants.iconWidget,
            SizedBox(height: 10.0),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
                bottom: 30,
              ),
            ),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }

  void _dispatchEvent(BuildContext context) {
    if (BlocProvider.of<LoginCubit>(context).checkIfPinCodeExists())
      BlocProvider.of<LaunchingCubit>(context).launchLoginScreen();
    else
      BlocProvider.of<LaunchingCubit>(context).launchSetPinCodeScreen();
  }
}
