import 'package:flutter/material.dart';
import 'package:siopa/app/screen/minor_screen.dart/widget.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

class EditStoreScreen extends StatelessWidget {
  const EditStoreScreen({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xBlue),
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: const EdgeInsets.all(20),
        alignLabelWithHint: true,
        labelStyle: const TextStyle(color: xWhite),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xBlue),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xGreen),
          borderRadius: BorderRadius.circular(25),
        ));
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Edit Store"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TextTitle(
              title: "Store Logo",
              ls: 0,
              fontwght: FontWeight.normal,
              fontsz: 18,
            ),
            LogoChangingWidget(data: data),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Divider(
                thickness: 2.5,
                color: xGrey,
              ),
            ),
            CoverChangingWidget(data: data),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Divider(
                thickness: 2.5,
                color: xGrey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: data['storename'],
                decoration: inputDecoration.copyWith(
                  labelText: "Store Name",
                  labelStyle: const TextStyle(color: xBlue),
                  hintText: "Enter Store Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: data['phone'],
                decoration: inputDecoration.copyWith(
                  labelText: "Phoen No",
                  labelStyle: const TextStyle(color: xBlue),
                  hintText: "Enter Phone Number",
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(xBlue)),
                      onPressed: () {},
                      child: const TextTitle(
                          color: xWhite,
                          title: 'Cancel',
                          ls: 0,
                          fontwght: FontWeight.normal,
                          fontsz: 16)),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(xBlue)),
                      onPressed: () {},
                      child: const TextTitle(
                          color: xWhite,
                          title: 'Save Changes',
                          ls: 0,
                          fontwght: FontWeight.normal,
                          fontsz: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
