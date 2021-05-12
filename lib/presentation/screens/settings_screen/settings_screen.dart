import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/presentation/router/app_router.dart';
import '../../../core/themes/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool showBiometricOptions = false;

  @override
  Future<void> didChangeDependencies() async {
    if (await BlocProvider.of<AuthCubit>(context).isBiometricSupported())
      setState(() {
        showBiometricOptions = true;
      });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildBody(context),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settings),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        buildThemeSettings(context),
        Divider(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        buildBiometricLoginSettings(context),
        Divider(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouterNames.setPinCode);
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(AppLocalizations.of(context)!.changePin)),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildBiometricLoginSettings(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool enabledBiometric;
        if (state is BiometricOn)
          enabledBiometric = true;
        else
          enabledBiometric = false;

        return Padding(
          padding: EdgeInsets.only(
            left: AppConstants.defaultPadding,
            right: AppConstants.defaultPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 9,
                child: InkWell(
                  onTap: () {
                    if (enabledBiometric)
                      BlocProvider.of<AuthCubit>(context)
                          .setBiometricLoginOff();
                    else
                      BlocProvider.of<AuthCubit>(context).setBiometricLoginOn();
                  },
                  child: Row(
                    children: [
                      Flexible(
                        flex: 8,
                        child: Text(
                          AppLocalizations.of(context)!.biometricLogin,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Switch(
                          activeColor: Theme.of(context).colorScheme.secondary,
                          onChanged: (bool value) {
                            if (value)
                              BlocProvider.of<AuthCubit>(context)
                                  .setBiometricLoginOn();
                            else
                              BlocProvider.of<AuthCubit>(context)
                                  .setBiometricLoginOff();
                          },
                          value: enabledBiometric,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  child: Icon(Icons.info_outline),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text(AppLocalizations.of(context)!.biometricInfo),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildThemeSettings(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          buildSectionHeader(
            context: context,
            sectionName: AppLocalizations.of(context)!.theme,
          ),
          GroupButton(
            selectedButtons: [
              BlocProvider.of<ThemeCubit>(context)
                  .getCurrentThemeMode()
                  .themeName(context: context)
            ],
            spacing: AppConstants.defaultPadding * 2,
            borderRadius:
                BorderRadius.circular(AppConstants.defaultCircularBorderRadius),
            isRadio: true,
            selectedColor: Theme.of(context).colorScheme.secondary,
            selectedTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            unselectedColor: Theme.of(context).colorScheme.onBackground,
            unselectedTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.background,
            ),
            buttons: [
              ThemeMode.light.themeName(context: context),
              ThemeMode.dark.themeName(context: context),
              ThemeMode.system.themeName(context: context),
            ],
            onSelected: (index, isSelected) {
              switch (index) {
                case 0:
                  BlocProvider.of<ThemeCubit>(context).setLightTheme();
                  break;
                case 1:
                  BlocProvider.of<ThemeCubit>(context).setDarkTheme();
                  break;
                case 2:
                  BlocProvider.of<ThemeCubit>(context).setSystemTheme();
                  break;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildSectionHeader(
      {required BuildContext context, required String sectionName}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            sectionName,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
