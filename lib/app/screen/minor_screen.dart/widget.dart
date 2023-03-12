import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/supplier_control/edit_store.dart';
import '../../utils/colors.dart';
import '../../widget/button_container.dart';

class CoverChangingWidget extends StatelessWidget {
  const CoverChangingWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditStoreProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
                radius: 60,
                backgroundColor: xGrey,
                backgroundImage: NetworkImage(data['coverimage'])),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(xBlue)),
                    onPressed: () {
                      value.pickStoreCover();
                    },
                    child: const TextTitle(
                        title: "Change",
                        color: xWhite,
                        ls: 0,
                        fontwght: FontWeight.normal,
                        fontsz: 17)),
                value.imgFileCover == null
                    ? const SizedBox()
                    : ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(xBlue)),
                        onPressed: () {
                          value.resetCover();
                        },
                        child: const TextTitle(
                            title: "Reset",
                            color: xWhite,
                            ls: 0,
                            fontwght: FontWeight.normal,
                            fontsz: 17)),
              ],
            ),
            value.imgFileCover == null
                ? const SizedBox()
                : CircleAvatar(
                    radius: 60,
                    backgroundColor: xGrey,
                    backgroundImage:
                        FileImage(File(value.imgFileCover?.path ?? '')),
                  ),
          ],
        );
      },
    );
  }
}

class LogoChangingWidget extends StatelessWidget {
  const LogoChangingWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditStoreProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: xGrey,
              backgroundImage: NetworkImage(data['storelogo']),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(xBlue)),
                    onPressed: () {
                      value.pickStoreLogo();
                    },
                    child: const TextTitle(
                        title: "Change",
                        color: xWhite,
                        ls: 0,
                        fontwght: FontWeight.normal,
                        fontsz: 17)),
                value.imgFileLogo == null
                    ? const SizedBox()
                    : ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(xBlue)),
                        onPressed: () {
                          value.resetLogo();
                        },
                        child: const TextTitle(
                            title: "Reset",
                            color: xWhite,
                            ls: 0,
                            fontwght: FontWeight.normal,
                            fontsz: 17)),
              ],
            ),
            value.imgFileLogo == null
                ? const SizedBox()
                : CircleAvatar(
                    radius: 60,
                    backgroundColor: xGrey,
                    backgroundImage:
                        FileImage(File(value.imgFileLogo?.path ?? '')),
                  ),
          ],
        );
      },
    );
  }
}
