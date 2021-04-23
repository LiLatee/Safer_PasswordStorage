import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/home_screen/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
    }
  }
}
