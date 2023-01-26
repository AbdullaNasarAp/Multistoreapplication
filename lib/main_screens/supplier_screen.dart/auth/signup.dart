import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:siopa/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/main_screens/costumer_screen/bottum_nav.dart';
import 'package:siopa/main_screens/supplier_screen.dart/auth/loginscreen.dart';
import 'package:siopa/main_screens/widget/button_container.dart';
import 'package:siopa/utils/colors.dart';
import 'package:siopa/widget/button_container.dart';

class SupplierSignUpScreen extends StatefulWidget {
  const SupplierSignUpScreen({super.key});

  @override
  State<SupplierSignUpScreen> createState() => _SupplierSignUpScreenState();
}

class _SupplierSignUpScreenState extends State<SupplierSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: xBlack87,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Sopia",
                        style: TextStyle(
                          color: xWhite,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.adobe_rounded,
                        color: xBlue,
                        size: 38,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextTitle(
                        title: "Supplier Sign Up",
                        ls: 0,
                        fontwght: FontWeight.bold,
                        fontsz: 24),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: xBlack87,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: xBlue, width: 1)),
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_a_photo,
                            size: 20,
                            color: xWhite,
                          ),
                          TextTitle(
                              title: "Add you Image",
                              ls: 0,
                              fontwght: FontWeight.normal,
                              fontsz: 10)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () {
                          log("Go to Camera");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: xBlack87,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: xBlue, width: 1)),
                          height: 45,
                          width: 45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.camera_alt),
                              TextTitle(
                                  title: "Camera",
                                  ls: 0,
                                  fontwght: FontWeight.normal,
                                  fontsz: 8)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          log("Go 2 gallery");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: xBlack87,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: xBlue, width: 1)),
                          height: 45,
                          width: 45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.album),
                              TextTitle(
                                  title: "Gallery",
                                  ls: 0,
                                  fontwght: FontWeight.normal,
                                  fontsz: 8)
                            ],
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Name',
                      contentPadding: const EdgeInsets.all(13),
                      labelStyle: const TextStyle(color: xWhite),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: xBlue),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: xGreen),
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      contentPadding: const EdgeInsets.all(13),
                      labelStyle: const TextStyle(color: xWhite),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: xBlue),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: xGreen),
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      contentPadding: const EdgeInsets.all(13),
                      labelStyle: const TextStyle(color: xWhite),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: xBlue),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: xGreen),
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const CostumerHomeScreen(),
                    ));
                  },
                  child: const ButtonContainer(
                    kWidth: 400,
                    kHeight: 50,
                    kColors: xBlue,
                    title: "Sign Up",
                    ls: 0,
                    fontwght: FontWeight.normal,
                    fontsz: 14,
                    bRadius: 25,
                    icons: Icons.arrow_forward,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Textbutton(
                  colors: xBlue,
                  title: "Do you want to buy products  ? ",
                  ontap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const CostumerLoginScreen(),
                    ));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ContainerButtonImage(
                        image: "images/inapp/google.png",
                        onPress: () {},
                        title: "Google"),
                    ContainerButtonImage(
                        image: "images/inapp/facebook.png",
                        onPress: () {},
                        title: "Facebook"),
                    ContainerButtonImage(
                        image: "images/inapp/guest.png",
                        onPress: () {},
                        title: "Guest"),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
