import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/presentation/widgets_templates/field_widget.dart';

class FirstLaunchScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Welcome in my app!\nI am sorry... in YOUR app!",
              style: Theme.of(context).textTheme.headline3,
              softWrap: true,
            ),
            Text(
              "I see you here for the first time. I need just one thing and then you can start to use your beautifull app.",
              style: Theme.of(context).textTheme.bodyText1,
              softWrap: true,
            ),
            Text(
              "That thing is a key/password which is going to use to encrypt Your precious data.",
              style: Theme.of(context).textTheme.bodyText1,
              softWrap: true,
            ),
            FieldWidget(
              label: 'Your Key',
              controller: controller,
            ),
            TextButton(
              onPressed: () {
                log("HALO");
                // BlocProvider.of<PreferencesCubit>(context).setKey(key: key);
              },
              child: Text("START"),
            ),
          ],
        ),
      ),
    );
  }
}
