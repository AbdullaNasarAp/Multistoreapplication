import 'package:flutter/material.dart';

import 'package:siopa/app/widget/app_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Edit Profile"),
        leading: const AppBarbackButton(),
      ),
    );
  }
}
