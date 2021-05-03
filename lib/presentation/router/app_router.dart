import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/home_screen/home_screen.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/home_screen/widgets/key_is_needed_dialog.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/keyIsNeededDialog':
        return MaterialPageRoute(
          builder: (context) => KeyIsNeededDialog(),
          fullscreenDialog: true,
        );
    }
  }
}
