import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/supplier_control/edit_store.dart';
import '../../utils/colors.dart';
import '../../widget/button_container.dart';
import '../main_screens/costumer_screen/sub_screen/profile/widget/add_address.dart';
import '../main_screens/costumer_screen/sub_screen/profile/widget/address_list.dart';

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

class PlaceOrderAddressTile extends StatelessWidget {
  const PlaceOrderAddressTile({
    super.key,
    required this.costumerAddress,
  });

  final QueryDocumentSnapshot<Object?> costumerAddress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddressBook(),
        ));
      },
      child: Card(
        color: xBlue,
        child: ListTile(
          trailing: costumerAddress['default'] == true
              ? const Icon(
                  Icons.home,
                  color: xWhite,
                )
              : const SizedBox(),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle(
                    title:
                        "Name: ${costumerAddress['firstname']} ${costumerAddress['lastname']}",
                    ls: 0,
                    color: xWhite,
                    fontwght: FontWeight.normal,
                    fontsz: 14),
                TextTitle(
                    title: "Phone: ${costumerAddress['phone']} ",
                    ls: 0,
                    color: xWhite,
                    fontwght: FontWeight.normal,
                    fontsz: 14),
                TextTitle(
                    title:
                        "Street  ${costumerAddress['street']}               ",
                    ls: 0,
                    color: xWhite,
                    fontwght: FontWeight.normal,
                    fontsz: 13),
                TextTitle(
                    title: "Pincode: s${costumerAddress['pincode']}",
                    ls: 0,
                    color: xWhite,
                    fontwght: FontWeight.normal,
                    fontsz: 13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTitle(
                        title: "City: ${costumerAddress['city']},",
                        ls: 0,
                        color: xWhite,
                        fontwght: FontWeight.normal,
                        fontsz: 13),
                    TextTitle(
                        title: "State: ${costumerAddress['state']},",
                        ls: 0,
                        color: xWhite,
                        fontwght: FontWeight.normal,
                        fontsz: 13),
                    TextTitle(
                        title: "Country: ${costumerAddress['country']}",
                        ls: 0,
                        color: xWhite,
                        fontwght: FontWeight.normal,
                        fontsz: 13)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceOrderEmptyAddressTile extends StatelessWidget {
  const PlaceOrderEmptyAddressTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddAddress(),
        ));
      },
      child: const SizedBox(
        width: double.infinity,
        height: 100,
        child: Card(
            color: xBlue,
            child: Center(
              child: TextTitle(
                title: "Set Address",
                color: xWhite,
                ls: 0,
                fontwght: FontWeight.bold,
                fontsz: 20,
              ),
            )),
      ),
    );
  }
}
