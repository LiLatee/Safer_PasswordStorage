import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/launching_cubit.dart';
import '../../../core/constants/AppConstants.dart' as AppConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with WidgetsBindingObserver {
  bool wasAuthenticationShowed = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BlocProvider.of<AuthCubit>(context)
        .authenticateWithBiometrics(context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if ((state is SecurityModeOff) || (state is Authenticated)) {
            BlocProvider.of<LaunchingCubit>(context).launchHomeScreen();
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SecurityModeOn) {
            return buildIfPhoneSecurityIsDisabled();
          } else
            return buildIfPhoneSecurityIsEnabled(context);
        },
      ),
    );
  }

  Widget buildIfPhoneSecurityIsDisabled() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.securityRequired),
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.setSecurity,
            ),
            onPressed: () async => AppSettings.openSecuritySettings(),
          ),
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.skipSecurity,
            ),
            onPressed: () =>
                BlocProvider.of<AuthCubit>(context).setSecurityModeOff(),
          ),
        ],
      ),
    );
  }

  Widget buildIfPhoneSecurityIsEnabled(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          BlocProvider.of<AuthCubit>(context)
              .authenticateWithBiometrics(context: context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login),
            SizedBox(
              width: AppConstants.defaultPadding,
            ),
            Text(AppLocalizations.of(context)!.signIn),
          ],
        ),
      ),
    );
  }
}
