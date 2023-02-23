// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/supplier_control/s_signup_c.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/sbottum_nav.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/button_container.dart';

class SupplierSignUpScreen extends StatelessWidget {
  SupplierSignUpScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldMessengerState> scaffoldKeys =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ScaffoldMessenger(
        key: scaffoldKeys,
        child: Scaffold(
          backgroundColor: xBlack87,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Consumer<SupplierSignupProvider>(
                  builder: (context, sSp, child) {
                    return Column(
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
                            const TextTitle(
                                title: "Supplier Sign Up",
                                ls: 0,
                                color: xWhite,
                                fontwght: FontWeight.bold,
                                fontsz: 20),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: xBlack87,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: xBlue, width: 1)),
                                height: 150,
                                width: 150,
                                child: sSp.imgFile == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 20,
                                            color: xWhite,
                                          ),
                                          TextTitle(
                                              title: "Add your Logo",
                                              color: xWhite,
                                              ls: 0,
                                              fontwght: FontWeight.normal,
                                              fontsz: 10)
                                        ],
                                      )
                                    : Image(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(sSp.imgFile!.path)))),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      sSp.pickImageFromCamera();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: xBlack87,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: xBlue, width: 1)),
                                      height: 45,
                                      width: 45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.camera_alt),
                                          TextTitle(
                                              color: xWhite,
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
                                      sSp.pickImageFromGallery();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: xBlack87,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: xBlue, width: 1)),
                                      height: 45,
                                      width: 45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.album),
                                          TextTitle(
                                              color: xWhite,
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
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your Store Name";
                            }
                            return null;
                          },
                          //  controller: _nameController,
                          onChanged: (value) {
                            sSp.storeName = value;
                          },
                          style: const TextStyle(color: xWhite),
                          decoration: InputDecoration(
                              labelText: 'Store Name',
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              labelStyle: const TextStyle(color: xWhite),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xGreen),
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter you Email";
                            } else if (value.isEmailValidate() == false) {
                              return "Invalid Email";
                            } else if (value.isEmailValidate() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            sSp.email = value;
                          },
                          style: const TextStyle(color: xWhite),
                          // controller: _emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: 'Email',
                              contentPadding: const EdgeInsets.all(13),
                              labelStyle: const TextStyle(color: xWhite),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xGreen),
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter you Password";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            sSp.password = value;
                          },
                          style: const TextStyle(color: xWhite),
                          obscureText: sSp.passwordVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    sSp.passwordVisibily();
                                  },
                                  icon: Icon(
                                    sSp.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: xWhite,
                                  )),
                              labelText: 'Password',
                              contentPadding: const EdgeInsets.all(13),
                              labelStyle: const TextStyle(color: xWhite),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xGreen),
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter you Password";
                            }
                            return null;
                          },
                          style: const TextStyle(color: xWhite),
                          onChanged: (value) {
                            sSp.password = value;
                          },
                          obscureText: sSp.passwordVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelText: 'Confirm Password',
                              contentPadding: const EdgeInsets.all(13),
                              labelStyle: const TextStyle(color: xWhite),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xGreen),
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const SupplierHomeScreen(),
                            ));
                          },
                          child: InkWell(
                            onTap: () {
                              sSp.signUp(context, scaffoldKeys, formKey);
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                FirebaseAuth.instance.signInAnonymously();
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: xBlack,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "images/inapp/google.png",
                                        filterQuality: FilterQuality.high,
                                        cacheHeight: 40,
                                        cacheWidth: 40,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Google",
                                      style: TextStyle(color: xGrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: xBlack,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "images/inapp/facebook.png",
                                        filterQuality: FilterQuality.high,
                                        cacheHeight: 40,
                                        cacheWidth: 40,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Facebook",
                                      style: TextStyle(color: xGrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                FirebaseAuth.instance.signInAnonymously();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      const SupplierHomeScreen(),
                                ));
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: xBlack,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "images/inapp/guest.png",
                                        filterQuality: FilterQuality.high,
                                        cacheHeight: 40,
                                        cacheWidth: 40,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Guest",
                                      style: TextStyle(color: xGrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
