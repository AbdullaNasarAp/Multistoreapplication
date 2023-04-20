import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../controller/costumer_control/address.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../widget/button_container.dart';
import 'add_address.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({
    super.key,
    required this.formKey,
    required this.scaffoldKey,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, aP, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: xBlack87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter you First Name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    aP.firstName = value!;
                  },
                  decoration: inputDecoration.copyWith(labelText: "First Name"),
                ),
                sizedBox,
                TextFormField(
                  style: const TextStyle(color: xBlack87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter you Last Name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    aP.lastName = value!;
                  },
                  decoration: inputDecoration.copyWith(labelText: "Last Name"),
                ),
                sizedBox,
                TextFormField(
                  style: const TextStyle(color: xBlack87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter you Phone number";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    aP.phone = value!;
                  },
                  decoration: inputDecoration.copyWith(labelText: "Phone"),
                ),
                sizedBox,
                TextFormField(
                  style: const TextStyle(color: xBlack87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your Location";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    aP.location = value!;
                  },
                  decoration: inputDecoration.copyWith(labelText: "Location"),
                ),
                sizedBox,
                TextFormField(
                  style: const TextStyle(color: xBlack87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your Pincode";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    aP.pincode = value!;
                  },
                  decoration: inputDecoration.copyWith(labelText: "Pincode"),
                ),
              ],
            ),
            sizedBox20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectState(
                onCountryChanged: (value) {
                  aP.countrySelection(value);
                },
                onStateChanged: (value) {
                  aP.stateSelection(value);
                },
                onCityChanged: (value) {
                  aP.citySelection(value);
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(15),
                fillColor: xBlue,
                onPressed: () async {
                  aP.addAddress(context, formKey, scaffoldKey);
                },
                child: const TextTitle(
                    title: "Add Address",
                    ls: 0,
                    color: xWhite,
                    fontwght: FontWeight.normal,
                    fontsz: 16),
              ),
            )
          ],
        );
      },
    );
  }
}
