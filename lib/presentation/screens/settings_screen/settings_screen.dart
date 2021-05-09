import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/launching_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/themes/app_theme.dart';

class SettingsScreen extends StatelessWidget {
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
        Padding(
          padding: EdgeInsets.only(
            left: AppConstants.defaultPadding,
            right: AppConstants.defaultPadding,
            bottom: AppConstants.defaultPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSectionHeader(
                context: context,
                sectionName: "Blokada aplikacji",
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppConstants.defaultPadding),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    bool enabled;
                    if ((state is SecurityModeOn) || (state is Authenticated))
                      enabled = true;
                    else
                      enabled = false;

                    return Switch(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      onChanged: (bool value) {
                        BlocProvider.of<AuthCubit>(context)
                            .setSecurityRequired();
                        BlocProvider.of<LaunchingCubit>(context)
                            .launchAuthScreen();
                        Navigator.of(context).pop();
                      },
                      value: enabled,
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
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
                  .getCurrentThemeMode()!
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
