import 'package:flutter/material.dart';
import 'package:siopa/app/widget/app_bar.dart';
import '../../../../../../utils/colors.dart';
import 'address_form.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ScaffoldMessenger(
        key: scaffoldKey,
        child: Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(title: "Add Address"),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child:
                      AddressForm(formKey: formKey, scaffoldKey: scaffoldKey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: xBlue),
      borderRadius: BorderRadius.circular(25),
    ),
    contentPadding: const EdgeInsets.all(13),
    labelStyle: const TextStyle(color: xBlack87),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: xBlue),
      borderRadius: BorderRadius.circular(25),
    ),
    enabled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: xGreen),
      borderRadius: BorderRadius.circular(25),
    ));
