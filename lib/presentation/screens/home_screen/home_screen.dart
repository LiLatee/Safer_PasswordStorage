import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/core/themes/app_theme.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/preferences_cubit.dart';
import 'package:provider/provider.dart';

import 'widgets/add_account_floating_button.dart';
import 'widgets/list_of_accounts.dart';
import 'widgets/three_dots_menu/export_dialog.dart';
import 'widgets/three_dots_menu/import_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeType themeType =
        Provider.of<ThemeModel>(context, listen: false).themeType;
    return buildHomeScreen(context, themeType);
    // return BlocBuilder<PreferencesCubit, PreferencesState>(
    //   builder: (context, state) {
    //     if (state is PreferencesLoaded && state.keyExists)
    //       return buildHomeScreen(context, themeType);
    //     else if (state is PreferencesLoaded && !state.keyExists)
    //       Future.microtask(
    //           () => Navigator.pushNamed(context, '/keyIsNeededDialog'));

    //     return Center(child: CircularProgressIndicator());
    //   },
    // );
  }

  Localizations buildHomeScreen(BuildContext context, ThemeType themeType) {
    return Localizations.override(
      // TODO remove Localizations.override
      context: context,
      locale: const Locale('pl'),
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          // color: Theme.of(context).colorScheme.primary,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  // color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: menuIconOnPressed,
              ),
              Spacer(),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    // color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: searchIconOnPressed),
              PopupMenuButton(
                onSelected: popupMenuOnSelected,
                icon: Icon(
                  Icons.more_vert,
                  // color: Theme.of(context).colorScheme.onPrimary,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: "export",
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.arrow_upward),
                      title: Text(AppLocalizations.of(context)!.exportData),
                    ),
                  ),
                  PopupMenuItem(
                    value: "import",
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.arrow_downward),
                      title: Text(AppLocalizations.of(context)!.importData),
                    ),
                  ),
                  PopupMenuItem(
                    value: "theme",
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.circle,
                        // color: themeType == ThemeType.Light
                        //     ? Colors.black45
                        //     : Colors.white70,
                      ),
                      title: Text(
                        themeType == ThemeType.Light
                            ? AppLocalizations.of(context)!.darkTheme
                            : AppLocalizations.of(context)!.lightTheme,
                      ),
                    ),
                  ),
                  // const PopupMenuItem(
                  //   child: ListTile(
                  //     leading: Icon(Icons.article),
                  //     title: Text('Item 3'),
                  //   ),
                  // ),
                  // const PopupMenuDivider(),
                  // const PopupMenuItem(child: Text('Item A')),
                  // const PopupMenuItem(child: Text('Item B')),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: ListOfAccounts(),
          ),
        ),
        floatingActionButton: AddAccountFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void menuIconOnPressed() {
    UnimplementedError();
  }

  void searchIconOnPressed() {
    UnimplementedError();
  }

  void popupMenuOnSelected(value) {
    if (value == "export")
      showDialog(
        context: context,
        // builder: (context) => ExportDialog(),
        builder: (context) => Container(),
      );
    else if (value == 'import')
      showDialog(
        context: context,
        // builder: (context) => ImportDialog(),
        builder: (context) => Container(),
      );
    else if (value == 'theme')
      Provider.of<ThemeModel>(context, listen: false).toggleTheme();
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     title: Text("My Simple Password Storage"),
  //   );
  // }
}
